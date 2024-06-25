import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

Future<bool> patchClient(String? vanilla, String? directory, String? version, Function(String) log) async {
  try{
    if(vanilla == null || directory == null || version == null) {
      log('Directories are invalid');
      return false;
    }

    var vanillaDiretory = Directory(path.dirname(vanilla));
    var axonPath = Directory(directory);

    //Set-up custom directory
    log('Copy SCPSL Directory');
    await _copyDirectory(vanillaDiretory, axonPath, log);

    log('Download SCPSL.exe');
    var success = await _downloadFile('https://github.com/AxonSL/SLClientPatches/raw/main/$version/SCPSL.exe', path.join(directory,'SCPSL.exe'), log);
    if(success == false) return false;

    //Patch SCP:SL
    log('Patching GameAssemlby.dll');
    success = await _patchFile('https://raw.githubusercontent.com/AxonSL/SLClientPatches/main/$version/gameassembly.patches',File(path.join(directory,'GameAssembly.dll')), log);
    if(success == false) return false;

    log('Patching global-metadata.dat');
    success = await _patchFile('https://raw.githubusercontent.com/AxonSL/SLClientPatches/main/$version/global-metadata.patches', File(path.joinAll([directory,'SCPSL_Data','il2cpp_data','Metadata','global-metadata.dat'])), log);
    if(success == false) return false;
    
    //Download mods
    log('Download Melonloader');
    var melonPath = path.join(directory,'ml.zip');
    success = await _downloadFile('https://github.com/LavaGang/MelonLoader/releases/download/v0.6.2/MelonLoader.x64.zip', melonPath, log);
    if(success == false) return false;
    await _unzip(melonPath, log);
    await File(melonPath).delete();

    log('Download Axon Client');
    var axonZipPath = path.join(directory,'Axon.Client.zip');
    success = await _downloadFile('https://github.com/AxonSL/Axon/releases/latest/download/Axon.Client.zip', axonZipPath, log);
    if(success == false) return false;
    await _unzip(axonZipPath, log);
    await File(axonZipPath).delete();

    log('Finished Installtion');
    return true;
  } catch(e) {
    log('Error during installation: $e');
    return false;
  }
}

Future<bool> _copyDirectory(Directory sourceDir, Directory targetDir, Function(String) log) async {
  // Ensure the source directory exists
  if (!await sourceDir.exists()) {
    log('The Directory of the SCPSL.exe doesnt eixst?');
    return false;
  }

  // Ensure the target directory exists
  if (!await targetDir.exists()) {
    await targetDir.create(recursive: true);
  }

  // Get the absolute paths for comparison
  final sourcePath = sourceDir.absolute.path;
  final targetPath = targetDir.absolute.path;

  // Recursively copy the contents
  await for (var entity in sourceDir.list(recursive: true)) {
    final relativePath = entity.path.substring(sourcePath.length + 1);
    final newPath = targetDir.path + Platform.pathSeparator + relativePath;

    // Skip copying the target directory itself if encountered
    if (entity is Directory && entity.absolute.path == targetPath) {
      continue;
    }

    switch (path.basename(entity.path)) {
      case 'SCPSL.exe':
      case 'SL-AC.dll':
        break;
      default:
        log('Copying ${path.basename(entity.path)}');

        if (entity is Directory) {
          final newDir = Directory(newPath);
          await newDir.create(recursive: true);
        } else if (entity is File) {
          final newFile = File(newPath);
          await newFile.create(recursive: true);
          await entity.copy(newFile.path);
        }
    }
  }

  return true;
}

Future<bool> _downloadFile(String url, String savePath, Function(String) log) async {
  try {
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      var file = File(savePath);
      
      if(await file.exists() == false) {
        await file.create(recursive: true);
      }

      await file.writeAsBytes(response.bodyBytes);
    } else {
      log('Couldn\'t download file ${response.statusCode}');
    }
    return true;
  } catch (e) {
    log('Error while downloading file: $e');
    return false;
  }
}

Future<bool> _patchFile(String url, File file, Function(String) log) async {
  var response = await http.get(Uri.parse(url));
  if(response.statusCode != 200) return false;
  final patches = response.body.split('\n');

  for(var patch in patches) {
    log(patch);
  }

  List<int> bytes = await file.readAsBytes();

  for(var i = 1; i < patches.length; i++) {
    var patch = patches[i];
    if(patch.isEmpty) continue;

    final data = patch.split(':');
    var position = int.parse(data[0],radix: 16);
    var expected = int.parse(data[1],radix: 16);
    var toWrite = int.parse(data[2],radix: 16);

    var byte = bytes[position];
    if(byte != expected) {
      log('Found Invalid Byte while patching ... abort');
      return false;
    }

    bytes[position] = toWrite;
  }

  await file.writeAsBytes(bytes);
  log('successfully patched ${file.path}');
  return true;
}

//I don't know why, but the default method from archive thinks that the melonloader directory is a file and throws a error
Future<void> _unzip(String zipFilePath, Function(String) log) async {
  var destinationDirPath = path.dirname(zipFilePath);
  final bytes = await File(zipFilePath).readAsBytes();
  final archive = ZipDecoder().decodeBytes(bytes);

  for (final file in archive) {
    final filePath = '$destinationDirPath/${file.name}';
    log('Unzip $filePath');
    if (file.name.endsWith('/')) {
      Directory(filePath).create(recursive: true);
    } else {
      final data = file.content as List<int>;
      var finishedFile = File(filePath);

      await finishedFile.create(recursive: true);
      await finishedFile.writeAsBytes(data);
    }
  }
}