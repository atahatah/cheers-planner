part of '../../root.dart';

class VoteShellBranchData extends StatefulShellBranchData {
  const VoteShellBranchData();
}

class VoteRoute extends GoRouteData {
  const VoteRoute(this.eventId);
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VoteScreen(eventId: eventId);
  }
}

class VotedListRoute extends GoRouteData {
  const VotedListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VotedListScreen();
  }
}
