part of '../root.dart';

@TypedGoRoute<SignUpRoute>(
  path: '/auth',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SignInRoute>(path: 'signin'),
  ],
)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpScreen();
  }
}

class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignInScreen();
  }
}
