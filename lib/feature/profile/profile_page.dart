import 'package:activity/core/app_state.dart';
import 'package:activity/core/theme.dart';
import 'package:activity/feature/home/widget/bottomNavigatorWidget.dart';
import 'package:activity/feature/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ອອກຈາກລະບົບ?'),
        content: const Text('ທ່ານແນ່ໃຈບໍ່ວ່າຕ້ອງການອອກຈາກລະບົບ?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('ຍົກເລີກ')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('ອອກຈາກລະບົບ'),
          ),
        ],
      ),
    );
    if (ok == true) AppState.instance.logout();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final user = state.currentUser;
        if (user == null) return const SizedBox();
        final spent = state.myTickets.fold<int>(0, (s, t) => s + t.event.price);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).padding.top + 24, 20, 28),
                  decoration: const BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white,
                        child: Text(
                          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                          style: const TextStyle(
                              fontSize: 36, color: kPrimary, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(user.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(user.email, style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _stat('ບັດທັງໝົດ', '${state.myTickets.length}'),
                          _stat('ພ້ອມໃຊ້', '${state.activeTickets.length}'),
                          _stat('ໃຊ້ແລ້ວ', '${state.usedTickets.length}'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _section([
                  _tile(Icons.person_outline, 'ຊື່', trailing: user.name),
                  _tile(Icons.email_outlined, 'ອີເມວ', trailing: user.email),
                  _tile(Icons.phone_outlined, 'ເບີໂທ', trailing: user.phone),
                  _tile(Icons.payments_outlined, 'ຍອດໃຊ້ຈ່າຍທັງໝົດ',
                      trailing: '${formatPrice(spent)} ກີບ'),
                ]),
                _section([
                  _tile(Icons.edit_outlined, 'ແກ້ໄຂໂປຣໄຟລ໌',
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const EditProfilePage()))),
                  _tile(Icons.lock_outline, 'ປ່ຽນລະຫັດຜ່ານ',
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ChangePasswordPage()))),
                  _tile(Icons.confirmation_number_outlined, 'ບັດຂອງຂ້ອຍ',
                      onTap: () => mainTabIndex.value = 1),
                  _tile(Icons.notifications_outlined, 'ແຈ້ງເຕືອນ',
                      badge: state.unreadCount, onTap: () => mainTabIndex.value = 2),
                ]),
                _section([
                  _tile(Icons.help_outline, 'ຊ່ວຍເຫຼືອ',
                      onTap: () => showSnack(context, 'ຕິດຕໍ່: support@activity.la')),
                  _tile(Icons.info_outline, 'ກ່ຽວກັບແອັບ', trailing: 'v1.0.0'),
                ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout),
                    label: const Text('ອອກຈາກລະບົບ'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _stat(String label, String value) => Expanded(
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      );

  Widget _section(List<Widget> children) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(children: children),
      );

  Widget _tile(IconData icon, String title,
      {String? trailing, VoidCallback? onTap, int badge = 0}) {
    return ListTile(
      leading: Icon(icon, color: kPrimary),
      title: Text(title),
      onTap: onTap,
      trailing: trailing != null
          ? ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 170),
              child: Text(trailing,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600)),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badge > 0)
                  Badge(label: Text('$badge')),
                const Icon(Icons.chevron_right),
              ],
            ),
    );
  }
}
