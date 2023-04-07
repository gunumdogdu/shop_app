import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.amount,
    required this.id,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-12ee1-default-rtdb.europe-west1.firebasedatabase.app/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': total,
          'dateTime': DateTime.now().toIso8601String(),
          'products': [
            cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList()
          ]
        },
      ),
    );
    _orders.insert(
      0,
      OrderItem(
        amount: total,
        id: json.decode(response.body)['name'],
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
