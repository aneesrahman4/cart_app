import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cart_app/routes/app_route_constants.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  // Sample product list
  final List<Map<String, dynamic>> products = const [
    {'name': 'iPhone', 'price': '50000'},
    {'name': 'iPhone', 'price': '50000'},
    {'name': 'iPhone', 'price': '50000'},
    {'name': 'iPhone', 'price': '50000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Products',
          style: TextStyle(
            color: Color(0xFF5A78F0),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Color(0xFF5A78F0)),
            onPressed: () {
              context.pushNamed(AppRouteConstants.CartRouteName);
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return GestureDetector(
              onTap: () {
                context.pushNamed(
                  AppRouteConstants.ProductDetailRouteName,
                  pathParameters: {
                    'name': product['name'],
                    'price': product['price'],
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.image, size: 50)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '₹ ${product['price']}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    OutlinedButton(
                      onPressed: () {
                        // TODO: Add to cart logic here
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5A78F0),
                      ),
                      child: const Text('Add to cart'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
