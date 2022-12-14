import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/routes/product_arguments.dart';
import 'package:flutter_mvvm_project/app/routes/routing_constants.dart';
import 'package:flutter_mvvm_project/app/view_models/product_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../components/globals/white_space.dart';
import '../../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, productDetailsViewRoute,
              arguments: ProductArguments(
                id: product.id!,
                name: product.name,
                details: product.details,
                quantity: product.quantity,
                price: product.price,
                imageUrl: product.imageUrl,
                rating: product.rating,
                description: product.description,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                ),
              ),
              const WhiteSpace(
                size: 'xs',
              ),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toString()}',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart_sharp),
                      tooltip: 'Add product to cart',
                      onPressed: () async {
                        await productViewModel.addItemToCart(
                          productViewModel.getLoggedInUser()!.uid,
                          product.id,
                          product.name,
                          product.description,
                          product.quantity,
                          product.price,
                          product.imageUrl,
                        );

                        if (productViewModel.error == '') {
                          productViewModel.showToast(
                            'Item added to your shopping cart',
                          );
                        } else {
                          productViewModel.showToast(
                            'Unable to add item to your shopping cart',
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
