import 'dart:io';

import 'package:win32_registry/win32_registry.dart';
import 'package:vdf/vdf.dart';
import 'package:path/path.dart' as path;

const String _steam64Bit = 'SOFTWARE\\Wow6432Node\\Valve\\Steam';
const String _steam32Bit = 'SOFTWARE\\Valve\\Steam';

String? _steamPath;
File? _libraryFile;
String? _slPath;

String? getSteamPath() {
  if(_steamPath != null) {
    return _steamPath;
  }

  RegistryKey key;
  try {
    key = Registry.openPath(RegistryHive.localMachine,path: _steam64Bit);
  }
  catch(ex) {
    try{
      key = Registry.openPath(RegistryHive.localMachine,path: _steam64Bit);
    }
    catch(ex) {
      return null;
    }
  }
  _steamPath = key.getValue('InstallPath')?.data.toString();
  return _steamPath;
}

File? getLibraryFoldersFile() {
  if(_libraryFile != null) return _libraryFile;

  var steamPath = getSteamPath();
  if(steamPath == null) return null;

  var file = File(path.join(steamPath,'steamapps','libraryfolders.vdf'));
  if(!file.existsSync()) return null;

  _libraryFile = file;
  return file;
}

String? getSlPath() {
  if(_slPath != null) {
    return _slPath;
  }

  var file = getLibraryFoldersFile();
  if (file == null) return null;
  var content = file.readAsStringSync();
  var decoded = vdf.decode(content);

  if(!decoded.containsKey('libraryfolders')) return null;
  Map<dynamic,dynamic> libraries = decoded['libraryfolders'];

  for(var lib in libraries.values) {
    String steamPath = lib['path'];

    var exe = File(path.join(steamPath.replaceAll(Platform.pathSeparator+Platform.pathSeparator, Platform.pathSeparator),'steamapps','common','SCP Secret Laboratory','SCPSL.exe'));

    if(!exe.existsSync()) continue;
    _slPath = exe.path;
    return _slPath;
  }

  return null;
}
