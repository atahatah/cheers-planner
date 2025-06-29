// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$signUpRoute, $mainShellRouteData];

RouteBase get $signUpRoute => GoRouteData.$route(
  path: '/auth',

  factory: $SignUpRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: 'signin',

      factory: $SignInRouteExtension._fromState,
    ),
    GoRouteData.$route(
      path: 'register',

      factory: $RegisterRouteExtension._fromState,
    ),
  ],
);

extension $SignUpRouteExtension on SignUpRoute {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  String get location => GoRouteData.$location('/auth');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SignInRouteExtension on SignInRoute {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  String get location => GoRouteData.$location('/auth/signin');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RegisterRouteExtension on RegisterRoute {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  String get location => GoRouteData.$location('/auth/register');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRouteData => StatefulShellRouteData.$route(
  factory: $MainShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/events',

          factory: $EventListRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'create',

              factory: $CreateEventRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'management/:eventId',

              factory: $ManagementRouteExtension._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/vote',

          factory: $VotedListRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: ':eventId',

              factory: $VoteRouteExtension._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',

          factory: $SettingsRouteExtension._fromState,
        ),
      ],
    ),
  ],
);

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) =>
      const MainShellRouteData();
}

extension $EventListRouteExtension on EventListRoute {
  static EventListRoute _fromState(GoRouterState state) =>
      const EventListRoute();

  String get location => GoRouteData.$location('/events');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CreateEventRouteExtension on CreateEventRoute {
  static CreateEventRoute _fromState(GoRouterState state) =>
      const CreateEventRoute();

  String get location => GoRouteData.$location('/events/create');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ManagementRouteExtension on ManagementRoute {
  static ManagementRoute _fromState(GoRouterState state) =>
      ManagementRoute(state.pathParameters['eventId']!);

  String get location => GoRouteData.$location(
    '/events/management/${Uri.encodeComponent(eventId)}',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $VotedListRouteExtension on VotedListRoute {
  static VotedListRoute _fromState(GoRouterState state) =>
      const VotedListRoute();

  String get location => GoRouteData.$location('/vote');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $VoteRouteExtension on VoteRoute {
  static VoteRoute _fromState(GoRouterState state) =>
      VoteRoute(state.pathParameters['eventId']!);

  String get location =>
      GoRouteData.$location('/vote/${Uri.encodeComponent(eventId)}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location('/settings');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'edb280977529abbf58954179dfe301f76fd5c13f';

/// See also [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<GoRouter>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRef = AutoDisposeProviderRef<GoRouter>;
String _$appAuthListenableHash() => r'908eddede5ed9477ab4b0cb3dc5a4cc1ff9df2f4';

/// See also [appAuthListenable].
@ProviderFor(appAuthListenable)
final appAuthListenableProvider =
    AutoDisposeProvider<RouteRefreshListenable>.internal(
      appAuthListenable,
      name: r'appAuthListenableProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appAuthListenableHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppAuthListenableRef = AutoDisposeProviderRef<RouteRefreshListenable>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
