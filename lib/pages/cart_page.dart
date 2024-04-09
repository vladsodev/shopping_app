import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Shopping Bag',
          style: Theme.of(context).textTheme.titleMedium,
          )
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
        final cartItem = cart[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(cartItem['imageUrl'] as String),
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Delete',
                      style: Theme.of(context).textTheme.titleMedium,
                      ),
                    content: const Text(
                      'Are you sure you wanna remove this product from your cart?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<CartProvider>().removeProduct(cartItem);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]
                  );
                }
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          title: Text(
            cartItem['title'].toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          subtitle: Text('Lenght: ${cartItem['length']}'),
        );
        }
      ),
    );
  }
}