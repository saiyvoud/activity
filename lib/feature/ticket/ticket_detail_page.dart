import 'package:activity/core/app_state.dart';
import 'package:activity/core/models.dart';
import 'package:activity/core/theme.dart';
import 'package:activity/feature/ticket/ticket_widgets.dart';
import 'package:flutter/material.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;
  const TicketDetailPage({super.key, required this.ticket});

  Future<void> _useTicket(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.qr_code_scanner, size: 40, color: kPrimary),
        title: const Text('ນຳໃຊ້ບັດ?'),
        content: const Text(
          'ກົດຢືນຢັນເມື່ອພະນັກງານສະແກນບັດທີ່ປະຕູເຂົ້າງານ.\nບັດທີ່ໃຊ້ແລ້ວບໍ່ສາມາດໃຊ້ຊ້ຳໄດ້.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('ຍົກເລີກ')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('ຢືນຢັນໃຊ້ບັດ')),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      AppState.instance.useTicket(ticket);
      showSnack(context, 'ນຳໃຊ້ບັດສຳເລັດ ຂໍໃຫ້ມ່ວນກັບກິດຈະກຳ!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final e = ticket.event;
        final used = ticket.status == TicketStatus.used;
        return Scaffold(
          backgroundColor: kPrimary,
          appBar: AppBar(title: const Text('ລາຍລະອຽດບັດ')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      e.image,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(height: 150, color: Colors.grey.shade300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(e.title,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            StatusBadge(status: ticket.status),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _info('ວັນທີ', e.date),
                            _info('ເວລາ', e.time),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _info('ສະຖານທີ່', e.address),
                            _info('ລາຄາ', '${formatPrice(e.price)} ກີບ'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // ເສັ້ນຕັດບັດ
                  Row(
                    children: [
                      _notch(left: true),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, c) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              (c.maxWidth / 10).floor(),
                              (_) => Container(
                                  width: 5, height: 1.5, color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
                      _notch(left: false),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            TicketQr(data: ticket.code, size: 190, faded: used),
                            if (used)
                              Transform.rotate(
                                angle: -0.35,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red, width: 3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('ໃຊ້ແລ້ວ',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SelectableText(
                          ticket.code,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 20,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          used
                              ? 'ບັດນີ້ຖືກນຳໃຊ້ແລ້ວ'
                              : 'ສະແດງ QR ນີ້ໃຫ້ພະນັກງານທີ່ປະຕູເຂົ້າງານ',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                        const Divider(height: 30),
                        _kv('ຜູ້ຖື', AppState.instance.currentUser?.name ?? '-'),
                        _kv('ຊຳລະຜ່ານ', ticket.paymentMethod),
                        _kv('ຊື້ເມື່ອ', formatDateTime(ticket.purchasedAt)),
                        if (used && ticket.usedAt != null)
                          _kv('ໃຊ້ເມື່ອ', formatDateTime(ticket.usedAt!)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: used
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: kPrimary,
                      ),
                      onPressed: () => _useTicket(context),
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('ນຳໃຊ້ບັດ'),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _info(String label, String value) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      );

  Widget _kv(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(k, style: TextStyle(color: Colors.grey.shade600)),
            const Spacer(),
            Text(v, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      );

  Widget _notch({required bool left}) => Container(
        width: 12,
        height: 24,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.horizontal(
            left: left ? Radius.zero : const Radius.circular(12),
            right: left ? const Radius.circular(12) : Radius.zero,
          ),
        ),
      );
}
