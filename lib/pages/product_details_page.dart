import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
    });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  int selectedLength = 0;

  void onTap() {
    if (selectedLength != 0) {
      Provider.of<CartProvider>(context, listen: false)
      .addProduct({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'company': widget.product['company'],
        'length': selectedLength,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added succesfully!'),
          duration: Duration(milliseconds: 500),
        )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a length!'),
          duration: Duration(milliseconds: 500),
        )
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Details',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.product['imageUrl'] as String,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(245, 247, 249, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.product['price']} VP',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['lengthes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final length = (widget.product['lengthes'] as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLength = length;
                              });
                            },
                            child: Chip(
                              backgroundColor: selectedLength == length ? Theme.of(context).primaryColor : const Color.fromRGBO(255, 255, 255, 1),
                              label: Text('$length'),
                            )
                          ),
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        fixedSize: const Size(350, 50)
                      ),
                      onPressed: onTap, 
                      label: Text(
                        'Add to cart',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      icon: const Icon(
                        Icons.shopping_bag,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}