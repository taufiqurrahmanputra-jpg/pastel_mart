
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/product.dart';
import '../theme/app_colors.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                width: double.infinity,
                height: 280,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              product.category.toUpperCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                const SizedBox(width: 6),
                Text('${product.rating}'),
                const SizedBox(width: 20),
                const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text('${product.stock} tersedia'),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Deskripsi Produk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
