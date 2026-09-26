import 'package:activity/core/app_state.dart';
import 'package:activity/core/theme.dart';
import 'package:activity/data/events.dart';
import 'package:activity/feature/home/widget/bottomNavigatorWidget.dart';
import 'package:activity/feature/home/widget/category.dart';
import 'package:activity/feature/home/widget/product.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _query = '';
  int _category = 0;

  @override
  Widget build(BuildContext context) {
    final events = kEvents.where((e) {
      final matchCat = _category == 0 || e.category == kCategories[_category];
      final q = _query.trim().toLowerCase();
      final matchQuery = q.isEmpty ||
          e.title.toLowerCase().contains(q) ||
          e.address.toLowerCase().contains(q);
      return matchCat && matchQuery;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListenableBuilder(
                listenable: AppState.instance,
                builder: (context, _) {
                  final user = AppState.instance.currentUser;
                  final unread = AppState.instance.unreadCount;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 4, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => mainTabIndex.value = 3,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: kPrimary,
                            child: Text(
                              (user?.name.isNotEmpty ?? false)
                                  ? user!.name[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ສະບາຍດີ 👋',
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                              Text(
                                user?.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const Text('LA'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/512/197/197568.png',
                            height: 24,
                            errorBuilder: (_, __, ___) => const Icon(Icons.flag),
                          ),
                        ),
                        IconButton(
                          onPressed: () => mainTabIndex.value = 2,
                          icon: Badge(
                            isLabelVisible: unread > 0,
                            label: Text('$unread'),
                            child: const Icon(Icons.notifications_none),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(
                    hintText: 'ຄົ້ນຫາກິດຈະກຳ ....',
                    suffixIcon: Icon(Icons.search_outlined),
                  ),
                ),
              ),
              CategoryWidget(
                categories: kCategories,
                selected: _category,
                onChanged: (i) => setState(() => _category = i),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                child: Row(children: [
                  const Text('ກິດຈະກຳ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text('${events.length} ລາຍການ',
                      style: TextStyle(color: Colors.grey.shade600)),
                ]),
              ),
              if (events.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.event_busy, size: 60, color: Colors.grey.shade400),
                        const SizedBox(height: 8),
                        Text('ບໍ່ພົບກິດຈະກຳ',
                            style: TextStyle(color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Product(events: events),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
