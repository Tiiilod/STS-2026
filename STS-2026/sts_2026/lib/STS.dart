import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class STS2026 extends StatefulWidget {
  const STS2026({super.key});

  @override
  State<STS2026> createState() => _HttpApiState();
}

class _HttpApiState extends State<STS2026> {
  List data = [];
  bool isLoading = true;

  Future<void> ambilData() async {
    var response = await http.get(
      Uri.parse(
        'https://dummyjson.com/products?limit=10&skip=10&select=title,price,thumbnail',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        var hasil = jsonDecode(response.body);
        data = hasil["products"];
        isLoading = false;
      });
    } else {
      print("Gagal");
    }
  }

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Your Logo APK",
          style: GoogleFonts.lato(color: Colors.white),
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Image.network(
                              item['thumbnail'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Text('eror');
                              },
                            ),
                          ),

                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(width: 3),
                                    Text("4.5"),
                                  ],
                                ),

                                SizedBox(height: 6),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$ ${item['price']}",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Stok 500"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
