import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<dynamic, CartItem> _items = {};

  Map<dynamic, CartItem> get items => _items;

  void addItem(
      dynamic productId, double price, String title, CartItemType type) {
    _items[productId] = CartItem(
      id: productId,
      title: title,
      price: price,
      type: type,
    );
    notifyListeners();
  }

  CartItem? getItem(dynamic productId) {
    return _items[productId];
  }

  List<CartItem> getAllUslugaItems() {
    return _items.values
        .where((item) => item.type == CartItemType.usluga)
        .toList();
  }

  double getCartFullPrice() {
    return _items.values.fold(0.0, (sum, item) => sum + item.price);
  }

  void removeItem(dynamic productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}

enum CartItemType { test, usluga }

class CartItem {
  final dynamic id;
  final String title;
  final double price;
  final CartItemType type;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.type,
  });
}
