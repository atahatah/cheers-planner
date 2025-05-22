part of '../../root.dart';

@TypedStatefulShellRoute<MainShellRouteData>(
  branches: [
    TypedStatefulShellBranch<CounterShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CounterRoute>(path: '/counter'),
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

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.navigator});
  final StatefulNavigationShell navigator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigator,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigator.currentIndex,
        onDestinationSelected: (int index) {
          navigator.goBranch(
            index,
            initialLocation: index == navigator.currentIndex,
          );
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.add), label: 'Counter'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
