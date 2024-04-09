import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/widgets/product_card.dart';
import 'package:shopping_app/pages/product_details_page.dart';
import '../global_variables.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  final List<String> filters = const [
    'All',
    'Dates',
    'Presents',
    'Other',
  ];

  late String selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters.first;
  }
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.sizeOf(context);
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(35),
      )
    );

    return SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'V-Points\nShop',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    )
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                        
                      },
                      child: Chip(
                        backgroundColor: selectedFilter == filter 
                          ? Theme.of(context).colorScheme.primary  
                          : const Color.fromRGBO(245, 247, 249, 1),
                        label: Text(filter),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        labelStyle: const TextStyle(fontSize: 16),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        shape: const StadiumBorder(
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 650) {
                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: constraints.maxWidth/700,
                      ), 
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductDetailsPage(product: product);
                                }
                              )
                            );
                          },
                          child: ProductCard(
                            title: product['title'] as String, 
                            price: product['price'] as double, 
                            image: product['imageUrl'] as String,
                            backgroundColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                          ),
                        );
                      }
                    );
                  } else {
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductDetailsPage(product: product);
                                }
                              )
                            );
                          },
                          child: ProductCard(
                            title: product['title'] as String, 
                            price: product['price'] as double, 
                            image: product['imageUrl'] as String,
                            backgroundColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                          ),
                        );
                      }
                    );
                  }
                } 
              ),
            ),
            
                
            
          ],
        ),
      );
  }
}