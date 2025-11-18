import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:arabgokstore_mobile/models/product_entry.dart';
import 'package:arabgokstore_mobile/widgets/product_entry_card.dart';
import 'package:arabgokstore_mobile/screens/product_detail.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  Future<List<ProductEntry>> fetchMyProducts(CookieRequest request) async {
    final response = await request.get(
      'http://localhost:8000/json/my-products/',
    );
    List<ProductEntry> myProducts = [];

    for (var d in response) {
      if (d != null) {
        final product = ProductEntry.fromJson(d);
        myProducts.add(product);
      }
    }
    return myProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('My Products')),
      body: FutureBuilder(
        future: fetchMyProducts(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Column(
              children: [
                Text(
                  "You haven't created any products yet.",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
              ],
            );
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              return ProductEntryCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
