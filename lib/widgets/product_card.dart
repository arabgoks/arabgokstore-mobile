import 'package:arabgokstore_mobile/screens/my_products_list.dart';
import 'package:flutter/material.dart';
import 'package:arabgokstore_mobile/screens/productlist_form.dart';
import 'package:arabgokstore_mobile/screens/menu.dart';
import 'package:arabgokstore_mobile/screens/product_entry_list.dart';

class ItemCard extends StatelessWidget {
  // Menampilkan kartu dengan ikon dan nama.
  final ItemHomepage item; 

  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    return Material(
      // Pakai warna dari item supaya tiap kartu berwarna sesuai item.color
      color: item.color,
      // Membuat sudut kartu melengkung.
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        // Aksi ketika kartu ditekan.
        onTap: () {
          // Menampilkan pesan SnackBar saat kartu ditekan.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Create Products") {
            // Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ProductFormPage.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductFormPage()),
            );
          } else if (item.name == "All Products") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductEntryListPage()
                ),
            );
          } else if (item.name == "My Products") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyProductsPage()
                ),
            );
          }
        },
        // Container untuk menyimpan Icon dan Text
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              // Menyusun ikon dan teks di tengah kartu.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}