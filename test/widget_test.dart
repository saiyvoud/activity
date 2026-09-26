import 'package:activity/core/app_state.dart';
import 'package:activity/core/models.dart';
import 'package:activity/data/events.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final state = AppState.instance;

  test('login, buy ticket, use ticket, notifications', () {
    expect(state.login('demo@gmail.com', 'wrong'), isNotNull);
    expect(state.login('demo@gmail.com', '123456'), isNull);
    expect(state.isLoggedIn, isTrue);

    final bought = state.buyTickets(kEvents.first, 2, 'BCEL One');
    expect(bought.length, 2);
    expect(state.activeTickets.length, 2);

    state.useTicket(bought.first);
    expect(bought.first.status, TicketStatus.used);
    expect(state.activeTickets.length, 1);
    expect(state.usedTickets.length, 1);

    expect(state.unreadCount, greaterThan(0));
    state.markAllRead();
    expect(state.unreadCount, 0);

    state.logout();
    expect(state.isLoggedIn, isFalse);
  });

  test('register rejects duplicate email', () {
    expect(
      state.register(name: 'A', email: 'demo@gmail.com', phone: '12345678', password: '123456'),
      isNotNull,
    );
    expect(
      state.register(name: 'New', email: 'new@gmail.com', phone: '12345678', password: '123456'),
      isNull,
    );
    expect(state.myTickets, isEmpty);
    state.logout();
  });
}
