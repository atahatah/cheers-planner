import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UseGoogleMapController {
  const UseGoogleMapController(this.controller, this.onMapCreated);
  final GoogleMapController? controller;
  final void Function(GoogleMapController) onMapCreated;
}

UseGoogleMapController useGoogleMapController() {
  return use(const _GoogleMapControllerHook());
}

class _GoogleMapControllerHook extends Hook<UseGoogleMapController> {
  const _GoogleMapControllerHook();

  @override
  _GoogleMapControllerHookState createState() =>
      _GoogleMapControllerHookState();
}

class _GoogleMapControllerHookState
    extends HookState<UseGoogleMapController, _GoogleMapControllerHook> {
  GoogleMapController? _controller;

  void _handleCreated(GoogleMapController c) {
    _controller = c;
    setState(() {});
  }

  @override
  UseGoogleMapController build(BuildContext context) {
    return UseGoogleMapController(_controller, _handleCreated);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  String get debugLabel => 'useGoogleMapController';
}
