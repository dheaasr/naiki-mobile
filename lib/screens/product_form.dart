import 'package:flutter/material.dart';
import 'package:naiki_mob/screens/menu.dart';
import 'package:naiki_mob/widgets/left_drawer.dart';

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _description = "";
  String _category = "Gear";
  String _price = "0";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = ['Men', 'Women', 'Gear'];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Product Form')),
        backgroundColor: const Color.fromARGB(255, 58, 56, 55),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === NAME ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _name = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong!";
                    }
                    if (value.length < 3) {
                      return "Nama produk minimal 3 karakter!";
                    }
                    if (value.length > 50) {
                      return "Nama produk terlalu panjang (maks. 50 karakter)!";
                    }
                    return null;
                  },
                ),
              ),

              // === DESCRIPTION ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Produk",
                    labelText: "Deskripsi Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _description = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    if (value.length < 10) {
                      return "Deskripsi terlalu pendek (min. 10 karakter)!";
                    }
                    if (value.length > 300) {
                      return "Deskripsi terlalu panjang (maks. 300 karakter)!";
                    }
                    return null;
                  },
                ),
              ),

              // === CATEGORY ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category,
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (newValue) =>
                      setState(() => _category = newValue!),
                ),
              ),

              // === THUMBNAIL URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail (opsional)",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _thumbnail = value),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final urlPattern = RegExp(
                        r'^(https?:\/\/)?([\w\-])+\.{1}([a-zA-Z]{2,63})([\/\w\-\.\?&=%]*)?$',
                      );
                      if (!urlPattern.hasMatch(value)) {
                        return "Masukkan URL yang valid!";
                      }
                    }
                    return null;
                  },
                ),
              ),

              // === PRICE ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Harga Produk",
                    labelText: "Harga Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _price = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mohon cantumkan harga!";
                    }
                    final num? price = num.tryParse(value);
                    if (price == null) {
                      return "Harga harus berupa angka!";
                    }
                    if (price < 0) {
                      return "Harga tidak boleh negatif!";
                    }
                    return null;
                  },
                ),
              ),

              // === IS PROMO ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title:
                      const Text("Tandai sebagai Featured produk"),
                  value: _isFeatured,
                  onChanged: (value) =>
                      setState(() => _isFeatured = value),
                ),
              ),

              // === SAVE BUTTON ===
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 45, 58, 132)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Replace the URL with your app's URL
                      // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
                      // If you using chrome,  use URL http://localhost:8000
                      
                      final response = await request.postJson(
                        "http://localhost:8000/create-flutter/",
                        jsonEncode({
                          "name": _name,
                          "description": _description,
                          "thumbnail": _thumbnail,
                          "category": _category,
                          "price": _price,
                          "is_featured": _isFeatured,
                        }),
                      );
                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Product successfully saved!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Something went wrong, please try again."),
                          ));
                        }
                      }
                    }
                  },
                  child: const Text("Save",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}