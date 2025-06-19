import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cart_app/providers/cart_providers.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    double total = 0;
    for (var item in cartItems) {
      final product = item['product'] ?? item;
      final price = double.tryParse(product['price'].toString()) ?? 0;
      final quantity = item['quantity'] ?? 1;
      total += price * quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body:
          cartProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : cartProvider.error != null
              ? Center(
                child: Text(
                  cartProvider.error!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ), // Improved visibility
                ),
              )
              : cartItems.isEmpty
              ? const Center(
                child: Text(
                  "🛒 Your cart is empty",
                  style: TextStyle(fontSize: 18),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final product = item['product'] ?? item;
                        final cartItemId = item['_id']?.toString() ?? '';
                        final quantity = item['quantity'] ?? 1;

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image, size: 40),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'] ?? 'No Name',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "₹${product['price'].toString()}",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Text("Quantity: "),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                            ),
                                            onPressed: () async {
                                              if (cartItemId.isNotEmpty) {
                                                if (quantity > 1) {
                                                  await cartProvider
                                                      .updateCartItemQuantity(
                                                        cartItemId,
                                                        quantity - 1,
                                                      );
                                                } else {
                                                  await cartProvider
                                                      .deleteFromCart(
                                                        cartItemId,
                                                      );
                                                }
                                              }
                                            },
                                          ),
                                          Text('$quantity'),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                            ),
                                            onPressed: () async {
                                              if (cartItemId.isNotEmpty) {
                                                await cartProvider
                                                    .updateCartItemQuantity(
                                                      cartItemId,
                                                      quantity + 1,
                                                    );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (cartItemId.isNotEmpty) {
                                                await cartProvider
                                                    .deleteFromCart(cartItemId);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                            child: const Text(
                                              'Remove from cart',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Colors.black12),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
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
                              '₹${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2874F0),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Checkout is not implemented yet',
                                  ),
                                ),
                              );
                            },
                            child: const Text('Place Order'),
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
