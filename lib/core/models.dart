class EventItem {
  final int id;
  final String title;
  final String category;
  final String date;
  final String time;
  final String image;
  final String address;
  final int price;
  final String detail;

  const EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.image,
    required this.address,
    required this.price,
    required this.detail,
  });
}

class AppUser {
  String name;
  String email;
  String phone;
  String password;

  AppUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}

enum TicketStatus { active, used }

class Ticket {
  final String code;
  final EventItem event;
  final String ownerEmail;
  final String paymentMethod;
  final DateTime purchasedAt;
  TicketStatus status;
  DateTime? usedAt;

  Ticket({
    required this.code,
    required this.event,
    required this.ownerEmail,
    required this.paymentMethod,
    required this.purchasedAt,
    this.status = TicketStatus.active,
    this.usedAt,
  });
}

enum NotificationType { purchase, used, system, reminder }

class AppNotification {
  final String id;
  final String ownerEmail;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime createdAt;
  bool read;

  AppNotification({
    required this.id,
    required this.ownerEmail,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    this.read = false,
  });
}
