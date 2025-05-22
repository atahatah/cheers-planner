part of '../../root.dart';

class CounterShellBranchData extends StatefulShellBranchData {
  const CounterShellBranchData();
}

class CounterRoute extends GoRouteData {
  const CounterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterScreen();
  }
}
