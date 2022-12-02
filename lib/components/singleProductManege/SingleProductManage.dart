import "package:flutter/material.dart";
import 'package:shopp/models/ProductModel.dart';

class SingleProductManage extends StatelessWidget {
  final ProductModel product;

  const SingleProductManage(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        //se for colocar uma imagem dentro do circle usando backgorundImage
        //precisa usar construtor NetworkImage
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
        ),
        title: Text(product.title),
        //se for colocar row dentro do trailling precisa declar um width
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 20,
              ),
              Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              )
            ],
          ),
        ));
  }
}
