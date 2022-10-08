import 'package:http/http.dart' as http;

import '../model/Game_Model.dart';

class GameService {
  static Future<List<GameModel>> getGame() async {
    http.Response response = await http.get(
      Uri.parse('https://www.freetogame.com/api/games'),
    );
    return gameModelFromJson(response.body);
  }
}
