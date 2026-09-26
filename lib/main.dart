import 'package:activity/core/app_state.dart';
import 'package:activity/core/theme.dart';
import 'package:activity/feature/auth/login_page.dart';
import 'package:activity/feature/home/widget/bottomNavigatorWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const AuthGate(),
    );
  }
}

/// ສະແດງໜ້າ Login ຖ້າຍັງບໍ່ເຂົ້າລະບົບ, ບໍ່ດັ່ງນັ້ນສະແດງແອັບຫຼັກ
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: state.isLoggedIn
              ? const BottomNavigatorWidget(key: ValueKey('app'))
              : const LoginPage(key: ValueKey('login')),
        );
      },
    );
  }
}
