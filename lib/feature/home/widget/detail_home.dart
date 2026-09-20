import 'package:flutter/material.dart';

class DetailHome extends StatefulWidget {
  final dynamic product;
  const DetailHome({super.key, required this.product});

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  late dynamic product;

  @override
  void initState() {
    super.initState();
    product = widget.product; // ກຳນົດຄ່າກ່ອນນຳໄປໃຊ້
    print(product);
  }
// Function ຈັດຮູບແບບຕົວເລກໃຫ້ມີຈຸດຂັ້ນ (Thousands separator)
  String formatPrice(dynamic price) {
    if (price == null) return '0';
    // แปลງເປັນ string ແລ້ວໃຊ້ RegEx ໃສ່ຈຸດທຸກໆ 3 ຫຼັກ
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 28, 248),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 28, 248),
        leading: IconButton(
          onPressed: () => Navigator.pop(context), // ເພີ່ມປຸ່ມກົດກັບ
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.white),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white, // ປ່ຽນສີປຸ່ມ Buy ໃຫ້ເດັ່ນຂຶ້ນ
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "Buy",
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 4, 28, 248),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ພາບສະແດງຜົນ
            // ພາບສະແດງຜົນແບບມີເງົາ ແລະ ຊ້ອນທັບ
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 1. ຮູບພື້ນຫຼັງ (ເຮັດໃຫ້ມົວ ຫຼື ເປັນເງົາ)
                  Positioned.fill(
                    child: Image.network(product['image'], fit: BoxFit.cover),
                  ),
                  // ເພີ່ມ Container ສີດຳໂປ່ງໃສທັບຮູບພື້ນຫຼັງ ເພື່ອໃຫ້ເບິ່ງເປັນເງົາ/ມືດລົງ
                  Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.4)),
                  ),

                  // 2. ຮູບຫຼັກທີ່ຊ້ອນທັບຢູ່ດ້ານເທິງ (ຂະໜາດນ້ອຍກວ່າເລັກນ້ອຍ ຫຼື ເຕັມຈໍຕາມມັກ)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                       color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 5), // ເງົາຢູ່ດ້ານລຸ່ມ
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          product['image'],

                          width: double.infinity,

                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(Icons.error, color: Colors.white),
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
              child: Text(
                product['title'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // ຫາກ Data ບໍ່ມີ Key 'detail' ໃຫ້ປ້ອງກັນ Error (ໃຊ້ ?? ເພື່ອການວ່າງ)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
              child: Text(
                product['detail'] ?? 'ບໍ່ມີລາຍລະອຽດເພີ່ມເຕີມ',
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product['date'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.alarm, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        product['time'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product['address'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white54, height: 30),
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.credit_card, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "ລາຄາ: ${formatPrice(product['price'])} ກີບ", // ໃຊ້ Function ຈັດຮູບແບບ
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
