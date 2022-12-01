import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shopp/models/CartProductModel.dart';
import 'package:shopp/models/ProductModel.dart';

class CartProductProvider with ChangeNotifier {
  Map<String, CartProductModel> _cardProductModel = {};

  Map<String, CartProductModel> getAllProcut() => {..._cardProductModel};

  int get itemCount {
    return _cardProductModel.length;
  }

  double get shouldReturnTotalPrice {
    double total = 0.0;
    //precisa manter o valor anterior por isso +=
    _cardProductModel.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItemOfList(ProductModel productModel) {
    if (_cardProductModel.containsKey(productModel.id)) {
      _cardProductModel.update(
        productModel.id,
        (it) => CartProductModel(
            name: it.name,
            price: it.price,
            id: it.id,
            quantity: it.quantity + 1,
            productId: it.productId),
      );
      notifyListeners();
    } else {
      _cardProductModel.putIfAbsent(
        productModel.id,
        () => CartProductModel(
            name: productModel.title,
            price: productModel.price,
            id: "${Random().nextDouble().toString()}-${productModel.price}-${productModel.title}",
            quantity: 1,
            productId: productModel.id),
      );
      notifyListeners();
    }
  }

  void removeItemOfList(String id) {
    _cardProductModel.remove(id);
    notifyListeners();
  }

  void clearList() {
    _cardProductModel = {};
    notifyListeners();
  }
}
