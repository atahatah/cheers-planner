// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consult_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$consultEventControllerHash() =>
    r'0f7922f70305cbb5b9ff57e26c8fe6893e4028eb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ConsultEventController
    extends BuildlessAutoDisposeNotifier<ConsultEventState> {
  late final EventEntry initialEvent;

  ConsultEventState build(EventEntry initialEvent);
}

/// See also [ConsultEventController].
@ProviderFor(ConsultEventController)
const consultEventControllerProvider = ConsultEventControllerFamily();

/// See also [ConsultEventController].
class ConsultEventControllerFamily extends Family<ConsultEventState> {
  /// See also [ConsultEventController].
  const ConsultEventControllerFamily();

  /// See also [ConsultEventController].
  ConsultEventControllerProvider call(EventEntry initialEvent) {
    return ConsultEventControllerProvider(initialEvent);
  }

  @override
  ConsultEventControllerProvider getProviderOverride(
    covariant ConsultEventControllerProvider provider,
  ) {
    return call(provider.initialEvent);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'consultEventControllerProvider';
}

/// See also [ConsultEventController].
class ConsultEventControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ConsultEventController,
          ConsultEventState
        > {
  /// See also [ConsultEventController].
  ConsultEventControllerProvider(EventEntry initialEvent)
    : this._internal(
        () => ConsultEventController()..initialEvent = initialEvent,
        from: consultEventControllerProvider,
        name: r'consultEventControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$consultEventControllerHash,
        dependencies: ConsultEventControllerFamily._dependencies,
        allTransitiveDependencies:
            ConsultEventControllerFamily._allTransitiveDependencies,
        initialEvent: initialEvent,
      );

  ConsultEventControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialEvent,
  }) : super.internal();

  final EventEntry initialEvent;

  @override
  ConsultEventState runNotifierBuild(
    covariant ConsultEventController notifier,
  ) {
    return notifier.build(initialEvent);
  }

  @override
  Override overrideWith(ConsultEventController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConsultEventControllerProvider._internal(
        () => create()..initialEvent = initialEvent,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialEvent: initialEvent,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ConsultEventController, ConsultEventState>
  createElement() {
    return _ConsultEventControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConsultEventControllerProvider &&
        other.initialEvent == initialEvent;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialEvent.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ConsultEventControllerRef
    on AutoDisposeNotifierProviderRef<ConsultEventState> {
  /// The parameter `initialEvent` of this provider.
  EventEntry get initialEvent;
}

class _ConsultEventControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ConsultEventController,
          ConsultEventState
        >
    with ConsultEventControllerRef {
  _ConsultEventControllerProviderElement(super.provider);

  @override
  EventEntry get initialEvent =>
      (origin as ConsultEventControllerProvider).initialEvent;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
