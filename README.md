# Fake Store - Flutter Product Catalog App

A simple Flutter app that consumes the **Fake Store API** to display a
searchable product catalog. This project implements the **API part** of the
assignment: fetching data from a public REST API and presenting it properly.

## What it does

1.  Splash screen → navigates to Home after 2 seconds.
2.  Home screen fetches the product list from the API and shows it as cards.
3.  Each card shows image, title, price + category, and a short description.
4.  Search bar filters products by title or category in real time.
5.  Tap a card to open a detail screen with full information.
6.  Pull-to-refresh reloads the data.
7.  Proper loading, error, and empty states.

## API Used

**Fake Store API** — `https://fakestoreapi.com/api/products`

Returns a JSON array of products. Each product has `id`, `title`, `price`,
`description`, `category`, and `image`. No API key is required.

Example response (one product):

```json
{
  "id": 1,
  "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
  "price": 109.95,
  "description": "Your perfect companion...",
  "category": "men's clothing",
  "image": "https://fakestoreapi.com/img/..."
}
```

## Packages Used

| Package | Why it is used |
|---|---|
| `http` | To send GET requests to the API. |
| `cached_network_image` | To load product images and cache them locally. |
| `flutter_lints` | To keep the code clean and follow Flutter best practices. |

## Project Structure

```
lib/
├── main.dart                    # Entry point
├── models/
│   └── product.dart             # Product data class + JSON parsing
├── services/
│   └── product_api.dart         # API calls (GET request + error handling)
├── screens/
│   ├── splash_screen.dart       # Splash screen (auto-navigates to Home)
│   ├── home_screen.dart         # Home screen (list, search, states)
│   └── detail_screen.dart       # Detail screen (full product info)
└── widgets/
    └── product_card.dart        # Reusable product card widget
```

## How to Run

### Prerequisites

1.  Install **Flutter SDK**: https://docs.flutter.dev/get-started/install
2.  Install **Android Studio** (for the emulator) or connect a physical phone
    with USB debugging enabled.

### Steps

```bash
# 1. Clone or download this repository.

# 2. Go into the project folder.
cd fake_store_app

# 3. Get all packages.
flutter pub get

# 4. Run the app.
flutter run
```

## Screenshots

*(Add screenshots of Splash, Home, and Detail screens here.)*

## State Management

This project uses the **simplest** state management approach:
`setState` + `FutureBuilder`.

- `setState` rebuilds the widget when the search text changes.
- `FutureBuilder` handles the three states of the API call:
  **Loading** → **Data** → **Error**.

This is perfect for a small app and easy to explain in the viva.
