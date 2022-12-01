import 'package:flutter/material.dart';
import 'package:shopp/utils/ConstantsRoutes.dart';
import 'package:provider/provider.dart';
import '../../models/ProductModel.dart';
import '../../providers/CartProductProvider.dart';

class SingleShop extends StatelessWidget {
  const SingleShop({super.key});

  @override
  Widget build(BuildContext context) {
    //vou inibir qualquer mudança dessa lista usando false no listen
    final product = Provider.of<ProductModel>(context, listen: false);
    final cart = Provider.of<CartProductProvider>(context, listen: false);

    void handleNavigation() {
      Navigator.of(context)
          .pushNamed(ConstantRoutes.productDetail, arguments: product);
    }

    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        //com consumer garanto que apenas oque desejo vai alterar
        //no ultimo parametro e para definir um filho que nunca sera mudado ou seja
        //estatico
        leading: Consumer<ProductModel>(
          builder: (ctx, product, _) => IconButton(
            onPressed: () => product.toogleIsFavorite(),
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        trailing: IconButton(
          onPressed: () => cart.addItemOfList(product),
          icon: Icon(Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: GestureDetector(
            onTap: handleNavigation,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
