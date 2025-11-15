import 'package:flutter/material.dart';
// 1. IMPORT HALAMAN BARU ANDA
// Gunakan import relatif yang paling sederhana dan andal.
import 'product_grid_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas UI/UX Flutter',
      debugShowCheckedModeBanner: false, // Opsional: Menghilangkan banner debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade300),
        useMaterial3: true,
      ),
      // 2. TAMPILKAN HALAMAN PRODUK GRID SEBAGAI HOME
      home: const ProductGridPage(),
    );
  }
}