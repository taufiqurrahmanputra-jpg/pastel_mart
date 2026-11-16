
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../theme/app_colors.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchProducts() {
    context
        .read<ProductProvider>()
        .searchProducts(_searchController.text);
  }

  void _openProductDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          product: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                // HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20, 20, 20, 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.shopping_bag_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PastelMart',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Find your favorite products',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.textPrimary,
                        size: 27,
                      ),
                    ],
                  ),
                ),

                // SEARCH BAR
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _searchProducts(),
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _searchProducts,
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // SECTION TITLE
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20, 12, 20, 14,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Explore Products',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        '${provider.products.length} Products',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // PRODUCT LIST
                Expanded(
                  child: _buildProductContent(provider),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductContent(ProductProvider provider) {
    if (provider.isLoading && provider.products.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (provider.errorMessage != null &&
        provider.products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 55,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 12),
              const Text(
                'Oops! Something went wrong.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                provider.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => provider.fetchProducts(),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (provider.products.isEmpty) {
      return const Center(
        child: Text(
          'No products found.',
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return Stack(
      children: [
        GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          itemCount: provider.products.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.66,
          ),
          itemBuilder: (context, index) {
            final product = provider.products[index];

            return GestureDetector(
              onTap: () => _openProductDetail(product),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          color: AppColors.babyBlue.withValues(
                            alpha: 0.25,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: product.thumbnail,
                            fit: BoxFit.contain,
                            placeholder: (context, url) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Icon(
                                Icons.image_not_supported_outlined,
                                size: 40,
                                color: AppColors.textSecondary,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.category.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 9,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 14,
                                  color: Color(0xFFFFC857),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        if (provider.isLoading)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              color: AppColors.primary,
            ),
          ),
      ],
    );
  }
}
