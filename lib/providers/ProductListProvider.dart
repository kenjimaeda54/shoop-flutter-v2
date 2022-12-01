import 'package:flutter/material.dart';
import '../data/products.dart';
import '../models/ProductModel.dart';

//ChangeNotifier e um mixin
//mixin e como se eu copiasse as funcionalidades do arquivo que creiei
//e colase em um arquivo que esta usando ele
// ou seja ProductList
//mixin usa palavra with

//Em Dart não aceita multiplas heranças, mas com
//mixin eu consigo varios minxin
//https://www.treinaweb.com.br/blog/o-que-sao-mixins-e-qual-sua-importancia-no-dart
//resumindo estou pegando as funicionalidades do ChangeNotificer e disponibilizando para nos
class ProductListProvider with ChangeNotifier {
  final List<ProductModel> _products = mockShop;

  //se eu chamar apaenas products ao inves [...products]
  //esterei criando uma inferencia e minha lista original não ira atualizar
  //dessa maneria de fato sera a lista verdadeira
  List<ProductModel> getItens() => [..._products];

  List<ProductModel> getItensFilter() =>
      mockShop.where((it) => it.isFavorite).toList();

  void addProdct(ProductModel product) {
    _products.add(product);
    //esse metodo e do mixin
    //toda vez que algo ocorrer neste arquivo preciso notificar
    notifyListeners();
  }
}
