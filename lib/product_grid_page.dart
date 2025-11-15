import 'package:flutter/material.dart';

class ProductGridPage extends StatelessWidget {
  const ProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy terdiri dari nama hewan yang may di jual, harga, gambar, rating dan lokasi
    final List<Map<String, dynamic>> products = [
      {
        'name': 'cwimiiw_Anak kucing oren...',
        'price': 'Rp. 1.599.000',
        'image': 'meng.jpg',
        'rating': 4.5,
        'location': 'Surabaya',
      },
      {
        'name': 'bonbon_Anak anjing oren...',
        'price': 'Rp. 1.955.000',
        'image': 'njing.png',
        'rating': 4.5,
        'location': 'Sidoarjo',
      },
      {
        'name': 'Pipip_Hamster kiyoot',
        'price': 'Rp. 3.000.000',
        'image': 'hamster.jpg',
        'rating': 4.9,
        'location': 'Malang',
      },
      {
        'name': 'Jennie_Capybara cegil',
        'price': 'Rp. 7.586.000',
        'image': 'pybara.jpg',
        'rating': 4.2,
        'location': 'Jakarta',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100], // ini bagian background body atau halamanya pak
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.pink.shade300,
        toolbarHeight: 120,
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Row(
            children: [
              // Tombol Back untuk tambahan saja pak
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(width: 8),
              // Search Bar untuk tambahan saja juga
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // terdiri dari 2 Kolom
            childAspectRatio: 0.6, // Rasio tingginya card pak
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductGridItem(
              name: product['name'],
              price: product['price'],
              imagePath: product['image'],
              rating: product['rating'],
              location: product['location'],
            );
          },
        ),
      ),
    );
  }
}

// Widget untuk setiap item produk Card dengan state interaksi
class ProductGridItem extends StatefulWidget {
  final String name;
  final String price;
  final String imagePath;
  final double rating;
  final String location;

  const ProductGridItem({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath, 
    required this.rating,
    required this.location,
  });

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  bool _isTapped = false; // State untuk mengontrol warna Card saat ditekan

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        // Aksi ketika Card dilepas
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: Card(
        // Mengubah warna Card menjadi pink terang (Colors.pink.shade50) saat ditekan
        color: _isTapped ? const Color.fromARGB(255, 255, 172, 200) : Colors.white,
        elevation: 4.0, // Efek shadownya 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: _isTapped ? const Color.fromARGB(255, 255, 172, 200) : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Gambar/Icon Produk
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200], // Background jika gambar kosong
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/${widget.imagePath}', // Path: assets/namafile.jpg/png
                      fit: BoxFit.cover,
                      // Menampilkan pesan error jika file tidak ditemukan
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            'File aset\n${widget.imagePath}\ntidak ditemukan',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red.shade400, fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 2. Nama Produk 
              Text(
                widget.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600, 
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),

              // 3. Harga 
              Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, 
                ),
              ),
              const SizedBox(height: 6),

              // Rating, Lokasi, dan Tombol More
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Rating (Bintang Emas)
                  const Icon(
                    Icons.star,
                    color: Colors.amber, 
                    size: 14,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '${widget.rating}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),

                  // Lokasi (Icon Pin lokasi)
                  Icon(
                    Icons.location_on, 
                    color: const Color.fromARGB(255, 180, 4, 4), 
                    size: 14,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    widget.location,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  // Tombol Titik Tiga (More)
                  const Spacer(),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.pink.shade300,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}