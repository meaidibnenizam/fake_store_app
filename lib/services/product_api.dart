import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

/// This class is responsible for talking to the Fake Store REST API.
///
/// It hides the "how" of networking from the rest of the app so that the
/// UI code only has to call `ProductApi.fetchProducts()`.
class ProductApi {
  /// Base URL of the API. All endpoints start with this.
  static const String baseUrl = 'https://fakestoreapi.com';

  /// Endpoint that returns ALL products as a JSON array.
  static const String productsEndpoint = '/products';
  /// GET request to fetch the product list.
  ///
  /// We use `Future<List<Product>>` because the network call takes time.
  /// `Future` means "the result will arrive later". `async`/`await` lets us
  /// write the code in a readable, top-to-bottom order.
  Future<List<Product>> fetchProducts() async {
    // 1. Build the URI (full address) of the endpoint.
    final Uri uri = Uri.parse('$baseUrl$productsEndpoint');

    // 2. Send the GET request. `http.get` returns a Future<Response>.
    final http.Response response = await http.get(uri);

    // 3. Check the status code. 200 means "OK" (success).
    //    Anything else (404, 500...) means the server had a problem.
    if (response.statusCode != 200) {
      // We throw an exception so the UI layer can show a friendly error message.
      throw Exception(
        'Server error! Could not load products. (Status code: ${response.statusCode})',
      );
    }

    // 4. Convert the response body (a JSON string) into a Dart Map/List.
    //    `jsonDecode` turns the string into a List<Map<String, dynamic>>.
    final List<dynamic> decoded = jsonDecode(response.body) as List<dynamic>;

    // 5. Map each JSON object to a Product object using Product.fromJson.
    //    The `.map()` returns a List<Product>.
    final List<Product> products = decoded.map((dynamic item) {
      return Product.fromJson(item as Map<String, dynamic>);
    }).toList();

    return products;
  }
}
