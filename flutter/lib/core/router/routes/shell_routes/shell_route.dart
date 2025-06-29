part of '../../root.dart';

@TypedStatefulShellRoute<MainShellRouteData>(
  branches: [
    TypedStatefulShellBranch<EventShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<EventListRoute>(
          path: '/events',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<CreateEventRoute>(path: 'create'),
          ],
        ),
      ],
    ),
    // TypedStatefulShellBranch<CounterShellBranchData>(
    //   routes: <TypedRoute<RouteData>>[
    //     TypedGoRoute<CounterRoute>(path: '/counter'),
    //   ],
    // ),
    // TypedStatefulShellBranch<ChatShellBranchData>(
    //   routes: <TypedRoute<RouteData>>[TypedGoRoute<ChatRoute>(path: '/chat')],
    // ),
    TypedStatefulShellBranch<VoteShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<VotedListRoute>(path: '/vote'),
        TypedGoRoute<VoteRoute>(path: 'vote/:eventId'),
      ],
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

class _NavItem {
  const _NavItem(this.icon, this.label);

  final IconData icon;
  final String label;
}

const _navItems = <_NavItem>[
  _NavItem(Icons.event, 'Create'),
  // _NavItem(Icons.add, 'Counter'),
  // _NavItem(Icons.chat, 'Chat'),
  _NavItem(Icons.padding, 'Vote'),
  _NavItem(Icons.settings, 'Settings'),
];

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.navigator});

  final StatefulNavigationShell navigator;

  @override
  Widget build(BuildContext context) {
    final useRail = MediaQuery.of(context).size.width >= 600;
    final destinations = _navItems
        .map(
          (item) =>
              NavigationDestination(icon: Icon(item.icon), label: item.label),
        )
        .toList();

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
              destinations: _navItems
                  .map(
                    (item) => NavigationRailDestination(
                      icon: Icon(item.icon),
                      label: Text(item.label),
                    ),
                  )
                  .toList(),
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
