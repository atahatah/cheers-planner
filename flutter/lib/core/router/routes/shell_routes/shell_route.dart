part of '../../root.dart';

@TypedStatefulShellRoute<MainShellRouteData>(
  branches: [
    TypedStatefulShellBranch<CounterShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CounterRoute>(path: '/counter'),
      ],
    ),
    TypedStatefulShellBranch<ChatShellBranchData>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<ChatRoute>(path: '/chat')],
    ),
    TypedStatefulShellBranch<SettingsShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsRoute>(path: '/settings'),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ShellScreen(navigator: navigationShell);
  }
}

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.navigator});

  final StatefulNavigationShell navigator;

  @override
  Widget build(BuildContext context) {
    final useRail = MediaQuery.of(context).size.width >= 600;
    final destinations = const <NavigationDestination>[
      NavigationDestination(icon: Icon(Icons.add), label: 'Counter'),
      NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
      NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
    ];

    void onSelect(int index) {
      navigator.goBranch(
        index,
        initialLocation: index == navigator.currentIndex,
      );
    }

    if (useRail) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigator.currentIndex,
              onDestinationSelected: onSelect,
              labelType: NavigationRailLabelType.selected,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text('Counter'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.chat),
                  label: Text('Chat'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
            ),
            Expanded(child: navigator),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: navigator,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigator.currentIndex,
          onDestinationSelected: onSelect,
          destinations: destinations,
        ),
      );
    }
  }
}
