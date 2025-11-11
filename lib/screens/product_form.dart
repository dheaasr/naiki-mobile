import 'package:flutter/material.dart';
import 'package:naiki_mob/screens/menu.dart';
import 'package:naiki_mob/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _description = "";
  String _category = "Unisex";
  String _price = "0";
  String _thumbnail = "";
  bool _isPromo = false;

  final List<String> _categories = ['Men', 'Women', 'Kids', 'Unisex', 'Tools'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Product Form')),
        backgroundColor: const Color.fromARGB(255, 45, 58, 132),
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
                      const Text("Tandai sebagai produk yang sedang Promo"),
                  value: _isPromo,
                  onChanged: (value) =>
                      setState(() => _isPromo = value),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Produk berhasil ditambahkan'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nama: $_name'),
                                Text('Deskripsi: $_description'),
                                Text('Kategori: $_category'),
                                Text('Thumbnail: $_thumbnail'),
                                Text('Harga: $_price'),
                                Text('Promo: ${_isPromo ? "Ya" : "Tidak"}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                              Navigator.pop(context); // nutup dialog
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                                (route) => false, // hapus semua route lama biar ga bisa back
                              );
                            },
                            ),
                          ],
                        ),
                      );
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