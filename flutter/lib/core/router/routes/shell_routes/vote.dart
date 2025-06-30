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

class ResultRoute extends GoRouteData {
  const ResultRoute(this.eventId);
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResultScreen(eventId: eventId);
  }
}

class VoteConfirmRoute extends GoRouteData {
  const VoteConfirmRoute(this.eventId);
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final participant = state.extra as EventParticipant;
    return VoteConfirmScreen(eventId: eventId, participant: participant);
  }
}
