// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consult_event_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsultEventState {

 ChatState get chatState; EventEntry? get event; EventEntry? get proposed;
/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsultEventStateCopyWith<ConsultEventState> get copyWith => _$ConsultEventStateCopyWithImpl<ConsultEventState>(this as ConsultEventState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsultEventState&&(identical(other.chatState, chatState) || other.chatState == chatState)&&(identical(other.event, event) || other.event == event)&&(identical(other.proposed, proposed) || other.proposed == proposed));
}


@override
int get hashCode => Object.hash(runtimeType,chatState,event,proposed);

@override
String toString() {
  return 'ConsultEventState(chatState: $chatState, event: $event, proposed: $proposed)';
}


}

/// @nodoc
abstract mixin class $ConsultEventStateCopyWith<$Res>  {
  factory $ConsultEventStateCopyWith(ConsultEventState value, $Res Function(ConsultEventState) _then) = _$ConsultEventStateCopyWithImpl;
@useResult
$Res call({
 ChatState chatState, EventEntry? event, EventEntry? proposed
});


$ChatStateCopyWith<$Res> get chatState;$EventEntryCopyWith<$Res>? get event;$EventEntryCopyWith<$Res>? get proposed;

}
/// @nodoc
class _$ConsultEventStateCopyWithImpl<$Res>
    implements $ConsultEventStateCopyWith<$Res> {
  _$ConsultEventStateCopyWithImpl(this._self, this._then);

  final ConsultEventState _self;
  final $Res Function(ConsultEventState) _then;

/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatState = null,Object? event = freezed,Object? proposed = freezed,}) {
  return _then(_self.copyWith(
chatState: null == chatState ? _self.chatState : chatState // ignore: cast_nullable_to_non_nullable
as ChatState,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as EventEntry?,proposed: freezed == proposed ? _self.proposed : proposed // ignore: cast_nullable_to_non_nullable
as EventEntry?,
  ));
}
/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatStateCopyWith<$Res> get chatState {
  
  return $ChatStateCopyWith<$Res>(_self.chatState, (value) {
    return _then(_self.copyWith(chatState: value));
  });
}/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventEntryCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $EventEntryCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventEntryCopyWith<$Res>? get proposed {
    if (_self.proposed == null) {
    return null;
  }

  return $EventEntryCopyWith<$Res>(_self.proposed!, (value) {
    return _then(_self.copyWith(proposed: value));
  });
}
}


/// @nodoc


class _ConsultEventState implements ConsultEventState {
  const _ConsultEventState({required this.chatState, required this.event, this.proposed});
  

@override final  ChatState chatState;
@override final  EventEntry? event;
@override final  EventEntry? proposed;

/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsultEventStateCopyWith<_ConsultEventState> get copyWith => __$ConsultEventStateCopyWithImpl<_ConsultEventState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsultEventState&&(identical(other.chatState, chatState) || other.chatState == chatState)&&(identical(other.event, event) || other.event == event)&&(identical(other.proposed, proposed) || other.proposed == proposed));
}


@override
int get hashCode => Object.hash(runtimeType,chatState,event,proposed);

@override
String toString() {
  return 'ConsultEventState(chatState: $chatState, event: $event, proposed: $proposed)';
}


}

/// @nodoc
abstract mixin class _$ConsultEventStateCopyWith<$Res> implements $ConsultEventStateCopyWith<$Res> {
  factory _$ConsultEventStateCopyWith(_ConsultEventState value, $Res Function(_ConsultEventState) _then) = __$ConsultEventStateCopyWithImpl;
@override @useResult
$Res call({
 ChatState chatState, EventEntry? event, EventEntry? proposed
});


@override $ChatStateCopyWith<$Res> get chatState;@override $EventEntryCopyWith<$Res>? get event;@override $EventEntryCopyWith<$Res>? get proposed;

}
/// @nodoc
class __$ConsultEventStateCopyWithImpl<$Res>
    implements _$ConsultEventStateCopyWith<$Res> {
  __$ConsultEventStateCopyWithImpl(this._self, this._then);

  final _ConsultEventState _self;
  final $Res Function(_ConsultEventState) _then;

/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatState = null,Object? event = freezed,Object? proposed = freezed,}) {
  return _then(_ConsultEventState(
chatState: null == chatState ? _self.chatState : chatState // ignore: cast_nullable_to_non_nullable
as ChatState,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as EventEntry?,proposed: freezed == proposed ? _self.proposed : proposed // ignore: cast_nullable_to_non_nullable
as EventEntry?,
  ));
}

/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatStateCopyWith<$Res> get chatState {
  
  return $ChatStateCopyWith<$Res>(_self.chatState, (value) {
    return _then(_self.copyWith(chatState: value));
  });
}/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventEntryCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $EventEntryCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of ConsultEventState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventEntryCopyWith<$Res>? get proposed {
    if (_self.proposed == null) {
    return null;
  }

  return $EventEntryCopyWith<$Res>(_self.proposed!, (value) {
    return _then(_self.copyWith(proposed: value));
  });
}
}

// dart format on
