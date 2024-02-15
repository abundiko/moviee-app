import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/screens/home/home.dart';
import 'package:myapp/screens/home/profile.dart';
import 'package:unicons/unicons.dart';

final indexScreenProvider = StateProvider<int>((ref) => 0);

class IndexScreen extends ConsumerWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor),
      ),
      body: const _Body(),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: ref.watch(indexScreenProvider),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          type: BottomNavigationBarType.fixed,
          onTap: (value) =>
              ref.read(indexScreenProvider.notifier).state = value,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(UniconsSolid.house_user),
                label: "Home",
                backgroundColor: Colors.transparent),
            BottomNavigationBarItem(
              icon: Icon(UniconsSolid.bag),
              label: "Store",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: "Me",
            ),
          ]),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __BodyState();
}

class __BodyState extends ConsumerState<_Body> {
  final _controller = PageController(viewportFraction: .99);

  @override
  Widget build(BuildContext context) {
    ref.listen(indexScreenProvider, (_, nxt) {
      _controller.jumpToPage(nxt);
    });

    return PageView(
      controller: _controller,
      children: const [
        HomeScreen(),
        ProfileScreen(),
        ProfileScreen(),
        ProfileScreen(),
      ],
    );
  }
}
