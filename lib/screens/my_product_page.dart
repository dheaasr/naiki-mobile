import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:naiki_mob/models/product_entry.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products"),
      ),
      body: FutureBuilder(
        future: request.get("http://localhost:8000/my-products/"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                "You have no products.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          List products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = Welcome.fromJson(products[index]);
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.category),
              );
            },
          );
        },
      ),
    );
  }
}
