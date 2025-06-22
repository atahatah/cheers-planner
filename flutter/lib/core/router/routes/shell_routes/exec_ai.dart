part of '../../root.dart';

class ExecAiShellBranchData extends StatefulShellBranchData {
  const ExecAiShellBranchData();
}

class ExecAiRoute extends GoRouteData {
  const ExecAiRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ExecAiScreen();
  }
}
