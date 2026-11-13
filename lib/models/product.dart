/// This is the data model (Data Class) for a single product.
///
/// The API sends JSON like this:
/// {
///   "id": 1,
///   "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
///   "price": 109.95,
///   "description": "Your perfect companion...",
///   "category": "men's clothing",
///   "image": "https://fakestoreapi.com/img/71f3d0fa.ply"
/// }
///
/// We convert that JSON (a Map) into a Product object using
/// `fromJson`. This is called "JSON parsing" / "deserialization".
class Product {
  // These are `final` because a product's data should not change after creation.
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  /// Constructor - used when we create a Product object in our own code.
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  /// Named constructor that converts a JSON Map into a Product object.
  ///
  /// `json['title']` reads the value of the "title" key.
  /// `?? 'Unknown'` means: if the key does not exist, use 'Unknown' as a fallback
  /// (this is called the null-safety operator / null coalescing operator).
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown title',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? 'No description available.',
      category: json['category'] ?? 'uncategorized',
      image: json['image'] ?? '',
    );
  }

  /// A short subtitle for the list view, e.g. "$109.95  •  men's clothing".
  String get subtitle => '\$${price.toStringAsFixed(2)}  •  $category';

  /// The first sentence of the description, used as the "small description"
  /// in the list card.
  String get shortDescription {
    if (description.length <= 90) return description;
    return '${description.substring(0, 90)}...';
  }
}
