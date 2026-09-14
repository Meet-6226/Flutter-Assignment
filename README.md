# FreshCart - Dynamic Product Listing

FreshCart is a Flutter application that displays products dynamically using `ListView.builder`. The application includes a modern product listing interface with search and category filtering functionality.

## Features

* Dynamic product listing using `ListView.builder`
* Product data managed using a model class
* Search products by name or category
* Filter products by category
* Uses `StatefulWidget` and `setState()`
* Modern product card UI
* Product price and rating display
* Empty state when no products are found
* Responsive mobile-friendly layout

## Technologies Used

* Flutter
* Dart
* Material Design
* StatefulWidget
* setState()
* ListView.builder

## Project Structure

```text
lib/
│
├── main.dart
│
├── models/
│   └── product.dart
│
└── pages/
    └── product_page.dart
```

## How It Works

The application stores product information using a `Product` model class. Each product contains details such as name, category, price, rating, image, and description.

The products are displayed dynamically using `ListView.builder`. Instead of creating every product card manually, the application uses the product list to generate the cards automatically.

The search feature allows users to enter a product name or category. The product list is filtered based on the search text and updated using `setState()`.

Users can also select a category such as Electronics, Fashion, Beauty, Sports, or Accessories. The selected category is used along with the search text to display only the matching products.


## Learning Outcomes

Through this project, I learned how to:

* Create and use a Dart data model
* Display dynamic data using `ListView.builder`
* Use `StatefulWidget` for changing UI
* Update the UI using `setState()`
* Implement search functionality
* Implement category-based filtering
* Combine multiple filters
* Create reusable product cards
* Handle empty search results
* Build a clean and interactive Flutter interface

## Conclusion

This project helped me understand how dynamic data can be displayed and filtered in a Flutter application. It also gave me practical experience with model classes, `ListView.builder`, `StatefulWidget`, and `setState()`. The concepts used in this project can be applied to larger applications such as shopping apps, food delivery apps, and other applications that display lists of data.
