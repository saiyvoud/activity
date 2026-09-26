import 'package:activity/core/app_state.dart';
import 'package:activity/core/theme.dart';
import 'package:activity/feature/home/page/home.dart';
import 'package:activity/feature/notification/notification_page.dart';
import 'package:activity/feature/profile/profile_page.dart';
import 'package:activity/feature/ticket/my_tickets_page.dart';
import 'package:flutter/material.dart';

/// ໃຊ້ປ່ຽນແທັບຈາກໜ້າອື່ນ ເຊັ່ນ ຫຼັງຊື້ບັດແລ້ວໄປໜ້າ "ບັດຂອງຂ້ອຍ"
final ValueNotifier<int> mainTabIndex = ValueNotifier<int>(0);

class BottomNavigatorWidget extends StatefulWidget {
  const BottomNavigatorWidget({super.key});

  @override
  State<BottomNavigatorWidget> createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  final List<Widget> children = const [
    HomePage(),
    MyTicketsPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    mainTabIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: mainTabIndex,
      builder: (context, currentIndex, _) {
        return Scaffold(
          body: IndexedStack(index: currentIndex, children: children),
          bottomNavigationBar: ListenableBuilder(
            listenable: AppState.instance,
            builder: (context, _) {
              final unread = AppState.instance.unreadCount;
              final active = AppState.instance.activeTickets.length;
              return BottomNavigationBar(
                backgroundColor: kPrimary,
                currentIndex: currentIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white60,
                type: BottomNavigationBarType.fixed,
                onTap: (i) => mainTabIndex.value = i,
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'ໜ້າຫຼັກ'),
                  BottomNavigationBarItem(
                    icon: Badge(
                      isLabelVisible: active > 0,
                      label: Text('$active'),
                      backgroundColor: Colors.orange,
                      child: const Icon(Icons.confirmation_number),
                    ),
                    label: 'ບັດຂອງຂ້ອຍ',
                  ),
                  BottomNavigationBarItem(
                    icon: Badge(
                      isLabelVisible: unread > 0,
                      label: Text(unread > 99 ? '99+' : '$unread'),
                      child: const Icon(Icons.notifications),
                    ),
                    label: 'ແຈ້ງເຕືອນ',
                  ),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'ໂປຣໄຟລ໌'),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
