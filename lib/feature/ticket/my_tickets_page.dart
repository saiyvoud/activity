import 'package:activity/core/app_state.dart';
import 'package:activity/core/models.dart';
import 'package:activity/feature/home/widget/bottomNavigatorWidget.dart';
import 'package:activity/feature/ticket/ticket_detail_page.dart';
import 'package:activity/feature/ticket/ticket_widgets.dart';
import 'package:flutter/material.dart';

class MyTicketsPage extends StatelessWidget {
  const MyTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final active = state.activeTickets;
        final used = state.usedTickets;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('ບັດຂອງຂ້ອຍ'),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabs: [
                  Tab(text: 'ພ້ອມໃຊ້ (${active.length})'),
                  Tab(text: 'ໃຊ້ແລ້ວ (${used.length})'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _TicketList(
                  tickets: active,
                  emptyIcon: Icons.confirmation_number_outlined,
                  emptyText: 'ທ່ານຍັງບໍ່ມີບັດ',
                  showBuyButton: true,
                ),
                _TicketList(
                  tickets: used,
                  emptyIcon: Icons.history,
                  emptyText: 'ຍັງບໍ່ມີບັດທີ່ນຳໃຊ້ແລ້ວ',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TicketList extends StatelessWidget {
  final List<Ticket> tickets;
  final IconData emptyIcon;
  final String emptyText;
  final bool showBuyButton;

  const _TicketList({
    required this.tickets,
    required this.emptyIcon,
    required this.emptyText,
    this.showBuyButton = false,
  });

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(emptyIcon, size: 80, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              Text(emptyText, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
              if (showBuyButton) ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => mainTabIndex.value = 0,
                    child: const Text('ໄປຊື້ບັດ'),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tickets.length,
      itemBuilder: (context, i) => TicketCard(
        ticket: tickets[i],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TicketDetailPage(ticket: tickets[i])),
        ),
      ),
    );
  }
}

