import 'package:activity/core/app_state.dart';
import 'package:activity/core/models.dart';
import 'package:activity/core/theme.dart';
import 'package:activity/feature/home/widget/bottomNavigatorWidget.dart';
import 'package:flutter/material.dart';

class BuyTicketPage extends StatefulWidget {
  final EventItem event;
  const BuyTicketPage({super.key, required this.event});

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _PayMethod {
  final String name;
  final IconData icon;
  final Color color;
  const _PayMethod(this.name, this.icon, this.color);
}

const _methods = [
  _PayMethod('BCEL One', Icons.account_balance, Color(0xFFD32F2F)),
  _PayMethod('LDB Trust', Icons.account_balance_wallet, Color(0xFF1565C0)),
  _PayMethod('JDB Yes', Icons.qr_code_2, Color(0xFF2E7D32)),
  _PayMethod('ບັດເຄຣດິດ / ເດບິດ', Icons.credit_card, Color(0xFF6A1B9A)),
];

class _BuyTicketPageState extends State<BuyTicketPage> {
  int _qty = 1;
  int _method = 0;
  bool _loading = false;
  static const int _maxQty = 10;

  int get _total => widget.event.price * _qty;

  Future<void> _confirm() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ຢືນຢັນການຊື້ບັດ'),
        content: Text(
          '${widget.event.title}\nຈຳນວນ: $_qty ໃບ\nຊຳລະຜ່ານ: ${_methods[_method].name}\n\nລວມ: ${formatPrice(_total)} ກີບ',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('ຍົກເລີກ')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('ຢືນຢັນ')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1)); // ຈຳລອງການຊຳລະເງິນ
    final tickets =
        AppState.instance.buyTickets(widget.event, _qty, _methods[_method].name);
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => PurchaseSuccessPage(tickets: tickets, total: _total)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.event;
    final user = AppState.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('ຊື້ບັດ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ຂໍ້ມູນກິດຈະກຳ
          _card(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(e.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                          width: 80, height: 80, color: Colors.grey.shade300)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('📅 ${e.date}   ⏰ ${e.time}',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                      Text('📍 ${e.address}',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _title('ຈຳນວນບັດ'),
          _card(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ບັດທົ່ວໄປ', style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('${formatPrice(e.price)} ກີບ / ໃບ',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
                const Spacer(),
                _qtyButton(Icons.remove, _qty > 1 ? () => setState(() => _qty--) : null),
                SizedBox(
                  width: 40,
                  child: Text('$_qty',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                _qtyButton(Icons.add, _qty < _maxQty ? () => setState(() => _qty++) : null),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _title('ຂໍ້ມູນຜູ້ຊື້'),
          _card(
            child: Column(
              children: [
                _kv('ຊື່', user?.name ?? '-'),
                _kv('ອີເມວ', user?.email ?? '-'),
                _kv('ເບີໂທ', user?.phone ?? '-'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _title('ວິທີຊຳລະເງິນ'),
          _card(
            padding: EdgeInsets.zero,
            child: Column(
              children: List.generate(_methods.length, (i) {
                final m = _methods[i];
                final selected = _method == i;
                return ListTile(
                  onTap: () => setState(() => _method = i),
                  leading: CircleAvatar(
                    backgroundColor: m.color.withValues(alpha: 0.12),
                    child: Icon(m.icon, color: m.color),
                  ),
                  title: Text(m.name),
                  trailing: Icon(
                    selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: selected ? kPrimary : Colors.grey,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          _title('ສະຫຼຸບ'),
          _card(
            child: Column(
              children: [
                _kv('ລາຄາບັດ', '${formatPrice(e.price)} × $_qty'),
                _kv('ຄ່າທຳນຽມ', '0 ກີບ'),
                const Divider(),
                Row(
                  children: [
                    const Text('ລວມທັງໝົດ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Spacer(),
                    Text('${formatPrice(_total)} ກີບ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18, color: kPrimary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 90),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _loading ? null : _confirm,
            child: _loading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                : Text('ຊຳລະເງິນ ${formatPrice(_total)} ກີບ'),
          ),
        ),
      ),
    );
  }

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4),
        child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      );

  Widget _card({required Widget child, EdgeInsets padding = const EdgeInsets.all(12)}) =>
      Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: child,
      );

  Widget _kv(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(k, style: TextStyle(color: Colors.grey.shade600)),
            const Spacer(),
            Flexible(
              child: Text(v,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      );

  Widget _qtyButton(IconData icon, VoidCallback? onTap) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: onTap == null ? Colors.grey.shade200 : kPrimary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: onTap == null ? Colors.grey : Colors.white),
        ),
      );
}

class PurchaseSuccessPage extends StatelessWidget {
  final List<Ticket> tickets;
  final int total;
  const PurchaseSuccessPage({super.key, required this.tickets, required this.total});

  @override
  Widget build(BuildContext context) {
    final e = tickets.first.event;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, color: Colors.green.shade600, size: 80),
              ),
              const SizedBox(height: 20),
              const Text('ຊື້ບັດສຳເລັດ!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                'ທ່ານໄດ້ຊື້ບັດ "${e.title}" ຈຳນວນ ${tickets.length} ໃບ\nລວມ ${formatPrice(total)} ກີບ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700, height: 1.5),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                alignment: WrapAlignment.center,
                children: tickets
                    .map((t) => Chip(
                          label: Text(t.code,
                              style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                        ))
                    .toList(),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  mainTabIndex.value = 1;
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
                icon: const Icon(Icons.confirmation_number),
                label: const Text('ເບິ່ງບັດຂອງຂ້ອຍ'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                onPressed: () {
                  mainTabIndex.value = 0;
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
                child: const Text('ກັບໜ້າຫຼັກ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
