import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/components/forms/form_busy_button.dart';
import 'package:flutter_mvvm_project/app/components/globals/white_space.dart';
import 'package:flutter_mvvm_project/app/view_models/product_details_viewmodel.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body(
      {Key? key,
      this.id,
      required this.name,
      required this.details,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.rating,
      required this.description})
      : super(key: key);

  final String? id;
  final String name;
  final String details;
  final num price;
  final String imageUrl;
  final int quantity;
  final int rating;
  final String description;

  @override
  Widget build(BuildContext context) {
    final productDetailsViewModel = context.watch<ProductDetailsViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 280,
              ),
            ),
            const WhiteSpace(
              size: 'sm',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              description,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            const WhiteSpace(
              size: 'xs',
            ),
            const Text(
              'Rating',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const WhiteSpace(),
            _buildStars(4),
            const WhiteSpace(size: 'xs'),
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const WhiteSpace(),
            Text(
              details,
              style: const TextStyle(color: Colors.black54, fontSize: 15),
            ),
            const WhiteSpace(
              size: 'md',
            ),
            FormBusyButton(
              loading: productDetailsViewModel.loading,
              onSubmitAction: () async {
                await productDetailsViewModel.addItemToCart(
                  productDetailsViewModel.getLoggedInUser()!.uid,
                  id,
                  name,
                  description,
                  quantity,
                  price,
                  imageUrl,
                );

                if (productDetailsViewModel.error == '') {
                  productDetailsViewModel
                      .showToast('Item added to shopping cart');
                }
              },
              title: 'Add to Cart',
            )
          ],
        ),
      ),
    );
  }
}

_buildStars(rating) {
  List<Widget> listOfStars = [];

  for (int i = 0; i < rating; i++) {
    listOfStars.add(const Icon(
      Icons.star_rate_rounded,
      color: Colors.amber,
    ));
  }

  for (int i = 0; i < 5 - rating; i++) {
    listOfStars.add(const Icon(
      Icons.star_border_rounded,
      color: Colors.amber,
    ));
  }

  return Row(
    children: listOfStars,
  );
}
