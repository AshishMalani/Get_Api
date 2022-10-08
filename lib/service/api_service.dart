import 'package:api_get/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ProductModel>> getProducts() async {
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    return productModelFromJson(response.body);
  }
}
