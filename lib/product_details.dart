import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final String name;
  final String price;

  const ProductDetails({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Product Detail',
          style: TextStyle(
            color: Color(0xFF5A78F0),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF5A78F0)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[300],
                width: double.infinity,
                child: const Center(child: Icon(Icons.image, size: 100)),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5A78F0),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '₹ $price',
              style: const TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Add to cart logic
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF5A78F0),
                  side: const BorderSide(color: Color(0xFF5A78F0)),
                ),
                child: const Text('Add to cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
