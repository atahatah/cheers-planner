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

class CreateEventRoute extends GoRouteData {
  const CreateEventRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateEventScreen();
  }
}

class ManagementRoute extends GoRouteData {
  const ManagementRoute(this.eventId);
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ManagementScreen(eventId: eventId);
  }
}
