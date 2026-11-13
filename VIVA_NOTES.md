# Viva Preparation Notes — Fake Store Flutter App

এই ডকুমেন্টে viva-তে স্যার যেসব প্রশ্ন করতে পারেন, তার সহজ বাংলা উত্তর দেওয়া
হয়েছে। এটা একবার ভালোভাবে পড়ে নিলেই যেকোনো প্রশ্নের উত্তর দিতে পারবে।

---

## ১. তুমি কোন API ব্যবহার করেছো?

**উত্তর:**

Fake Store API।
- URL: `https://fakestoreapi.com/api/products`
- এটা একটা public REST API, কোনো API key লাগে না।
- এটা একটি JSON array return করে, যেখানে প্রতিটা product-এর `id`, `title`,
  `price`, `description`, `category`, আর `image` থাকে।

**কেন Fake Store API:**
- ছবি আছে (image) — UI দেখতে ভালো লাগে।
- Title, price, category, description — assignment-এ যা যা চাওয়া হয়েছে, সব আছে।
- JSON structure সহজ, বুঝতে সহজ।

---

## ২. API থেকে data কীভাবে fetch করেছো?

**উত্তর:**

`services/product_api.dart` ফাইলে `fetchProducts()` নামে একটা method আছে।

ধাপগুলো:
1. `Uri.parse(...)` দিয়ে URL-টা `Uri` object-এ রূপান্তর করা হয়।
2. `http.get(uri)` দিয়ে GET request পাঠানো হয়।
3. `await` দিয়ে response আসা পর্যন্ত অপেক্ষা করা হয়।
4. `response.statusCode == 200` হলে সফল।
5. `jsonDecode(response.body)` দিয়ে JSON string থেকে Dart List বানানো হয়।
6. প্রতিটা Map কে `Product.fromJson(...)` দিয়ে `Product` object-এ convert করা হয়।

---

## ৩. JSON parsing কী? কীভাবে করেছো?

**উত্তর:**

JSON parsing মানে JSON string থেকে Dart object বানানো।

`models/product.dart`-এ `Product.fromJson` নামে একটা factory constructor আছে।
যেমন:

```dart
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
```

`??` মানে: যদি null হয়, তাহলে default value দাও। এটা নাম null coalescing operator।

---

## ৪. State management কী ব্যবহার করেছো?

**উত্তর:**

`setState` + `FutureBuilder`।

- `FutureBuilder` API call-এর অবস্থা (loading, data, error) হ্যান্ডেল করে।
- `setState` শুধু search করার সময় ব্যবহার হয় — তুমি যা লিখবে, তা দিয়ে
  list-এ filter করবে, তারপর `setState` দিয়ে UI আবার build করবে।

কেন Provider/Bloc দেওয়া নাই:
- স্যার বলেছেন শুধু API part করতে।
- ছোট প্রজেক্টের জন্য `setState` + `FutureBuilder` যথেষ্ট।

---

## ৫. FutureBuilder কী? কীভাবে কাজ করে?

**উত্তর:**

`FutureBuilder` হলো একটা widget যেটা কোনো `Future`-এর result দেখে UI বানায়।

তিনটা অবস্থা হ্যান্ডেল করে:
1. `connectionState == ConnectionState.waiting` → Loading spinner দেখায়।
2. `snapshot.hasError` → Error message দেখায়।
3. `snapshot.hasData` → List-এ data দেখায়।

আমাদের `home_screen.dart`-এ এই তিনটা state-ই দেখানো আছে।

---

## ৬. Home screen-এ কী কী feature আছে?

**উত্তর:**

- AppBar-এ "Fake Store" লেখা, refresh button আছে।
- Search bar আছে, যা product title বা category দিয়ে filter করে।
- Product list দেখায় `ListView.builder` দিয়ে।
- প্রতিটা item-এ image, title, subtitle (price + category), আর short description আছে।
- Item tap করলে Detail screen-এ যায়।
- Pull-to-refresh দিয়ে API থেকে নতুন data নেওয়া যায়।

---

## ৭. Detail screen-এ কী দেখাও?

**উত্তর:**

Product-এর:
- Full image
- Category chip
- Title
- Price
- Full description

ডেটা Home screen থেকে constructor-এর মাধ্যমে pass করা হয়।

---

## ৮. Error handling কীভাবে করেছো?

**উত্তর:**

তিন লেয়ারে error handling আছে:

1. **API layer:** `if (response.statusCode != 200)` হলে `throw Exception(...)`।
2. **FutureBuilder layer:** `snapshot.hasError` হলে `_ErrorView` দেখায়, যেখানে
   "Try Again" বাটন আছে।
3. **Image layer:** `cached_network_image`-এর `errorWidget` যদি ছবি load না হয়।

---

## ৯. `pubspec.yaml`-এ কী কী package আছে?

**উত্তর:**

| Package | কাজ |
|---|---|
| `http` | API call করার জন্য। |
| `cached_network_image` | Remote image load আর cache করার জন্য। |
| `flutter_lints` | Lint rules, good practice ফলো করার জন্য। |

---

## ১০. Project structure-এ ফোল্ডার আলাদা করেছো কেন?

**উত্তর:**

Clean code আর separation of concerns-এর জন্য:

- `models/` → data class
- `services/` → API call
- `screens/` → page/widget যা user দেখে
- `widgets/` → reusable UI part

এতে code maintain করা সহজ আর viva-তে বলাও সহজ যে কোন কোড কোথায়।

---

## ১১. CRUD কেন দেওয়া নাই?

**উত্তর:**

স্যার আমাদের বলেছেন শুধু API part করতে। Full assignment-এ CRUD, cache,
pagination থাকলেও আমাদের নির্দেশনা ছিল শুধু API integration করা।

তবে যদি চান, বলতে পারি:
- Fake Store API create/update/delete support করে (POST/PUT/DELETE আছে),
- কিন্তু স্যারের নির্দেশনা অনুযায়ী আমি শুধু GET / product list দেখিয়েছি।

---

## ১২. তুমি AI ব্যবহার করেছো কিনা?

**উত্তর:**

হ্যাঁ, স্যারের নির্দেশনায় বলা আছে "You may use AI tools for assistance"।
তবে প্রতিটা লাইন বুঝেছি, comment দিয়ে ব্যাখ্যা করেছি, আর নিজে run করে test
করব।

---

## Demo Script (যদি স্যার app দেখতে বলেন)

> "স্যার, এটা Fake Store API থেকে প্রোডাক্ট লিস্ট আনে। স্প্লাশ স্ক্রিন দেখা
> যাচ্ছে — ২ সেকেন্ড পর হোম স্ক্রিনে চলে আসে। এখানে লোডিং স্পিনার দেখাচ্ছে,
> তারপর প্রোডাক্ট কার্ডগুলো আসছে। আমি সার্চ বারে 'shirt' লিখলে ফিল্টার হয়ে
> যায়। কোনো কার্ডে ক্লিক করলে ডিটেইল স্ক্রিনে ফুল ইনফরমেশন দেখায়।
> উপরের রিফ্রেশ বাটন বা pull-to-refresh দিয়ে API থেকে নতুন ডেটা নেওয়া যায়।"

---

## মনে রাখার চাবিকাঠি

- API = Fake Store API (`/api/products`)
- Package = `http` + `cached_network_image`
- State = `setState` + `FutureBuilder`
- Architecture = models / services / screens / widgets
- Feature = splash, list, search, detail, pull-to-refresh, loading/error states
