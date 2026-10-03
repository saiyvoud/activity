import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addUser({
  required String id,
  required String username,
  required String email,
  required String password,
  required String profile,
}) async {
  // ລະບຸຊື່ Table ທີ່ຕ້ອງການຢູ່ Path (ເຊັ່ນ /categories.json)
  final url = Uri.parse(
    'https://activity-lao-default-rtdb.asia-southeast1.firebasedatabase.app/users.json',
  );

  final response = await http.post(
    url,
    body: jsonEncode({
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profile': profile
    }),
  );
}
Future<void> addCategory() async {
  // ລະບຸຊື່ Table ທີ່ຕ້ອງການຢູ່ Path (ເຊັ່ນ /categories.json)
  final url = Uri.parse(
    'https://activity-lao-default-rtdb.asia-southeast1.firebasedatabase.app/categories.json',
  );

  final response = await http.post(
    url,
    body: jsonEncode({
      'category_name': 'Sports',
      'description': 'All sports activities',
    }),
  );
}