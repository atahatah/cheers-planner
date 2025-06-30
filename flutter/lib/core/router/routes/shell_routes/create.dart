part of '../../root.dart';

class EventShellBranchData extends StatefulShellBranchData {
  const EventShellBranchData();
}

class EventListRoute extends GoRouteData {
  const EventListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EventListScreen();
  }
}

class CreateRoute extends GoRouteData {
  const CreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreateEventScreen();
}

class ConsultRoute extends GoRouteData {
  const ConsultRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final entry = state.extra! as EventEntry;
    return ConsultEventScreen(entry: entry);
  }
}

class ManagementRoute extends GoRouteData {
  const ManagementRoute(this.eventId);
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ManagementScreen(eventId: eventId);
}

class DateSummaryRoute extends GoRouteData {
  const DateSummaryRoute(this.eventId);
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DateSummaryScreen(eventId: eventId);
}

class RecommendRoute extends GoRouteData {
  const RecommendRoute(this.eventId);
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ExecAiScreen(eventId: eventId);
}
