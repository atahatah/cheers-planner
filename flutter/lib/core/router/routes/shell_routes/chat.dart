part of '../../root.dart';

class ChatShellBranchData extends StatefulShellBranchData {
  const ChatShellBranchData();
}

class ChatRoute extends GoRouteData {
  const ChatRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChatScreen();
  }
}
