import 'package:http/http.dart' as http;

import '../model/CosmaticProduct.dart';

class CosmaticService {
  static Future<List<CosmaticProduct>> getData() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"),
    );
    return cosmaticProductFromJson(response.body);
  }
}
