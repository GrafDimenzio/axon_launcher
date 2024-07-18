import 'package:axon_launcher/api/io.dart';
import 'package:flutter/foundation.dart';

class ServerlistState with ChangeNotifier {
  static ServerlistState singleton = ServerlistState();

  List<String> favorites = [];
  List<String> history = [];

  void toggleFavorite(String favorite) {
    if(favorites.contains(favorite)) {
      favorites.remove(favorite);
    }
    else {
      favorites.add(favorite);
    }
    if(favoritesFile == null) return;
    favoritesFile!.writeAsString(favorites.join('\n'));

    notifyListeners();
  }

  void addToHistory(String server) {
    history.add(server);
    if(history.length > 10) {
      history.removeAt(0);
    }

    if(historyFile == null) return;
    historyFile!.writeAsString(history.join('\n'));

    notifyListeners();
  }
}