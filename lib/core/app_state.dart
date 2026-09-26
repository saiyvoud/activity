import 'dart:math';

import 'package:activity/core/models.dart';
import 'package:activity/core/theme.dart';
import 'package:flutter/foundation.dart';

/// State ຂອງແອັບທັງໝົດ (ເກັບໃນໜ່ວຍຄວາມຈຳ).
/// ໃຊ້ `AppState.instance` ແລະ ຟັງການປ່ຽນແປງດ້ວຍ ListenableBuilder.
class AppState extends ChangeNotifier {
  AppState._() {
    // ບັນຊີທົດລອງ
    _users.add(AppUser(
      name: 'Demo User',
      email: 'demo@gmail.com',
      phone: '02012345678',
      password: '123456',
    ));
  }

  static final AppState instance = AppState._();

  final List<AppUser> _users = [];
  final List<Ticket> _tickets = [];
  final List<AppNotification> _notifications = [];
  final Random _rand = Random();

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // ---------------- Auth ----------------

  /// ຄືນຄ່າ null ຖ້າສຳເລັດ, ຫຼື ຂໍ້ຄວາມ error
  String? login(String email, String password) {
    final e = email.trim().toLowerCase();
    final user = _users.where((u) => u.email == e).firstOrNull;
    if (user == null) return 'ບໍ່ພົບບັນຊີນີ້';
    if (user.password != password) return 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ';
    _currentUser = user;
    _addNotification(
      title: 'ເຂົ້າສູ່ລະບົບສຳເລັດ',
      body: 'ຍິນດີຕ້ອນຮັບກັບມາ ${user.name}!',
      type: NotificationType.system,
    );
    notifyListeners();
    return null;
  }

  String? register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    final e = email.trim().toLowerCase();
    if (_users.any((u) => u.email == e)) return 'ອີເມວນີ້ຖືກໃຊ້ແລ້ວ';
    final user = AppUser(
      name: name.trim(),
      email: e,
      phone: phone.trim(),
      password: password,
    );
    _users.add(user);
    _currentUser = user;
    _addNotification(
      title: 'ລົງທະບຽນສຳເລັດ 🎉',
      body: 'ຍິນດີຕ້ອນຮັບ ${user.name} ເຂົ້າສູ່ Activity. ເລີ່ມຊື້ບັດກິດຈະກຳໄດ້ເລີຍ!',
      type: NotificationType.system,
    );
    notifyListeners();
    return null;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void updateProfile({required String name, required String phone}) {
    final u = _currentUser;
    if (u == null) return;
    u.name = name.trim();
    u.phone = phone.trim();
    _addNotification(
      title: 'ອັບເດດໂປຣໄຟລ໌',
      body: 'ຂໍ້ມູນໂປຣໄຟລ໌ຂອງທ່ານຖືກອັບເດດແລ້ວ',
      type: NotificationType.system,
    );
    notifyListeners();
  }

  String? changePassword(String oldPass, String newPass) {
    final u = _currentUser;
    if (u == null) return 'ກະລຸນາເຂົ້າສູ່ລະບົບ';
    if (u.password != oldPass) return 'ລະຫັດຜ່ານເກົ່າບໍ່ຖືກຕ້ອງ';
    u.password = newPass;
    _addNotification(
      title: 'ປ່ຽນລະຫັດຜ່ານ',
      body: 'ລະຫັດຜ່ານຂອງທ່ານຖືກປ່ຽນແລ້ວ',
      type: NotificationType.system,
    );
    notifyListeners();
    return null;
  }

  // ---------------- Tickets ----------------

  List<Ticket> get myTickets {
    final u = _currentUser;
    if (u == null) return [];
    final list = _tickets.where((t) => t.ownerEmail == u.email).toList();
    list.sort((a, b) => b.purchasedAt.compareTo(a.purchasedAt));
    return list;
  }

  List<Ticket> get activeTickets =>
      myTickets.where((t) => t.status == TicketStatus.active).toList();

  List<Ticket> get usedTickets {
    final list = myTickets.where((t) => t.status == TicketStatus.used).toList();
    list.sort((a, b) => b.usedAt!.compareTo(a.usedAt!));
    return list;
  }

  String _newCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    return 'TK-${List.generate(8, (_) => chars[_rand.nextInt(chars.length)]).join()}';
  }

  List<Ticket> buyTickets(EventItem event, int quantity, String paymentMethod) {
    final u = _currentUser;
    if (u == null) return [];
    final now = DateTime.now();
    final bought = List.generate(
      quantity,
      (_) => Ticket(
        code: _newCode(),
        event: event,
        ownerEmail: u.email,
        paymentMethod: paymentMethod,
        purchasedAt: now,
      ),
    );
    _tickets.addAll(bought);
    _addNotification(
      title: 'ຊື້ບັດສຳເລັດ',
      body:
          'ທ່ານໄດ້ຊື້ບັດ "${event.title}" ຈຳນວນ $quantity ໃບ, ລວມ ${formatPrice(event.price * quantity)} ກີບ ຜ່ານ $paymentMethod',
      type: NotificationType.purchase,
    );
    _addNotification(
      title: 'ແຈ້ງເຕືອນກິດຈະກຳ',
      body: 'ຢ່າລືມ! "${event.title}" ວັນທີ ${event.date} ເວລາ ${event.time} ທີ່ ${event.address}',
      type: NotificationType.reminder,
    );
    notifyListeners();
    return bought;
  }

  void useTicket(Ticket ticket) {
    if (ticket.status == TicketStatus.used) return;
    ticket.status = TicketStatus.used;
    ticket.usedAt = DateTime.now();
    _addNotification(
      title: 'ນຳໃຊ້ບັດແລ້ວ',
      body: 'ບັດ ${ticket.code} ຂອງ "${ticket.event.title}" ຖືກນຳໃຊ້ເມື່ອ ${formatDateTime(ticket.usedAt!)}',
      type: NotificationType.used,
    );
    notifyListeners();
  }

  // ---------------- Notifications ----------------

  List<AppNotification> get myNotifications {
    final u = _currentUser;
    if (u == null) return [];
    final list = _notifications.where((n) => n.ownerEmail == u.email).toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  int get unreadCount => myNotifications.where((n) => !n.read).length;

  void _addNotification({
    required String title,
    required String body,
    required NotificationType type,
  }) {
    final u = _currentUser;
    if (u == null) return;
    _notifications.add(AppNotification(
      id: '${DateTime.now().microsecondsSinceEpoch}${_rand.nextInt(999)}',
      ownerEmail: u.email,
      title: title,
      body: body,
      type: type,
      createdAt: DateTime.now(),
    ));
  }

  void markRead(AppNotification n) {
    if (n.read) return;
    n.read = true;
    notifyListeners();
  }

  void markAllRead() {
    for (final n in myNotifications) {
      n.read = true;
    }
    notifyListeners();
  }

  void deleteNotification(AppNotification n) {
    _notifications.remove(n);
    notifyListeners();
  }

  void clearNotifications() {
    final u = _currentUser;
    if (u == null) return;
    _notifications.removeWhere((n) => n.ownerEmail == u.email);
    notifyListeners();
  }
}
