import 'package:flutter/material.dart';

// Dummy cart item model (You can replace with actual model later)
class CartItem {
  final String name;
  final String price;
  final int qty;

  CartItem({required this.name, required this.price, this.qty = 1});
}

// Dummy global cart items list
List<CartItem> cartItems = [
  CartItem(name: 'iPhone 13', price: '50000', qty: 1),
  CartItem(name: 'iPhone 14', price: '70000', qty: 2),
  CartItem(name: 'iPhone 15', price: '90000', qty: 1),
];

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += double.parse(item.price) * item.qty;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = calculateTotal();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Color(0xFF5A78F0),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5A78F0)),
      ),
      body:
          cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty.'))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.image, size: 30),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text('₹ ${item.price}'),
                                    Text('Qty: ${item.qty}'),
                                  ],
                                ),
                              ),
                              const Icon(Icons.close, color: Colors.grey),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Total Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      border: Border(top: BorderSide(color: Colors.black12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹ $totalAmount',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5A78F0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
