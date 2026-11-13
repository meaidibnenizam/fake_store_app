import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_api.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

/// The Home Screen shows the list of products fetched from the API.
///
/// State management here is done with `setState` + `FutureBuilder`:
///  - `FutureBuilder` shows Loading / Data / Error depending on the API call.
///  - `setState` rebuilds the widget when the search text changes.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // The API service instance.
  final ProductApi _api = ProductApi();

  // This Future holds the API call. FutureBuilder listens to it.
  late Future<List<Product>> _futureProducts;

  // All products as they came from the API.
  List<Product> _allProducts = [];

  // The products currently displayed (after search filter).
  List<Product> _visibleProducts = [];

  // The text typed in the search box.
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  /// Starts the API call.
  void _loadProducts() {
    _futureProducts = _api.fetchProducts();
  }

  /// Pull-to-refresh handler. It re-runs the API call.
  Future<void> _refresh() async {
    setState(() {
      _loadProducts();
    });
    // Wait until the new data arrives, then stop the refresh spinner.
    await _futureProducts;
  }

  /// Filters the product list based on the search text.
  void _filterProducts(String keyword) {
    setState(() {
      _searchText = keyword;

      if (keyword.trim().isEmpty) {
        // Empty search -> show everything.
        _visibleProducts = _allProducts;
      } else {
        // Otherwise keep only products whose title or category matches.
        _visibleProducts = _allProducts.where((Product p) {
          final String q = keyword.toLowerCase();
          return p.title.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake Store'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => _refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          // ---------------- Search bar ----------------
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                hintText: 'Search products or categories...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),

          // ---------------- Product list ----------------
          Expanded(
            child: FutureBuilder<List<Product>>(
              // The future we want to listen to.
              future: _futureProducts,

              // Called whenever the future's state changes.
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Product>> snapshot,
              ) {
                // CASE 1: Still loading -> show a loading indicator.
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // CASE 2: The request failed -> show an error message.
                if (snapshot.hasError) {
                  return _ErrorView(
                    message: snapshot.error.toString(),
                    onRetry: () {
                      setState(_loadProducts);
                    },
                  );
                }

                // The data has arrived successfully.
                final List<Product> products = snapshot.data ?? const [];

                // Save the data into our local variables the first time
                // the data arrives, so that search can filter it.
                if (_allProducts.isEmpty && products.isNotEmpty) {
                  _allProducts = products;
                  _visibleProducts = products;
                }

                // CASE 3: The API returned an empty list -> empty state.
                if (products.isEmpty) {
                  return const Center(
                    child: Text('No products found.'),
                  );
                }

                // CASE 4: Success -> show the list.
                return RefreshIndicator(
                  // Pull to refresh.
                  onRefresh: _refresh,
                  child: ListView.builder(
                    // `itemCount` is how many cards to build.
                    itemCount: _visibleProducts.length,

                    // `itemBuilder` builds one card at a time (lazy loading).
                    itemBuilder: (BuildContext context, int index) {
                      final Product product = _visibleProducts[index];

                      return ProductCard(
                        product: product,
                        onTap: () {
                          // Open the detail screen when a card is tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A separate widget for the error state, to keep the build method clean.
class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Could not load products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
