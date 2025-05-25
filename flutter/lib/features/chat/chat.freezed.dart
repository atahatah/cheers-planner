// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatMessage {

 Role get role; String get message;@DateTimeToTimestampConverter() DateTime? get sentAt;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.message, message) || other.message == message)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}


@override
int get hashCode => Object.hash(runtimeType,role,message,sentAt);

@override
String toString() {
  return 'ChatMessage(role: $role, message: $message, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 Role role, String message,@DateTimeToTimestampConverter() DateTime? sentAt
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? message = null,Object? sentAt = freezed,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc


class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.role, required this.message, @DateTimeToTimestampConverter() this.sentAt});
  

@override final  Role role;
@override final  String message;
@override@DateTimeToTimestampConverter() final  DateTime? sentAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.message, message) || other.message == message)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}


@override
int get hashCode => Object.hash(runtimeType,role,message,sentAt);

@override
String toString() {
  return 'ChatMessage.completedMessage(role: $role, message: $message, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 Role role, String message,@DateTimeToTimestampConverter() DateTime? sentAt
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? message = null,Object? sentAt = freezed,}) {
  return _then(_ChatMessage(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _ChatMessageReceiving implements ChatMessage {
  const _ChatMessageReceiving({required this.role, required this.message, @DateTimeToTimestampConverter() this.sentAt});
  

@override final  Role role;
@override final  String message;
@override@DateTimeToTimestampConverter() final  DateTime? sentAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageReceivingCopyWith<_ChatMessageReceiving> get copyWith => __$ChatMessageReceivingCopyWithImpl<_ChatMessageReceiving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageReceiving&&(identical(other.role, role) || other.role == role)&&(identical(other.message, message) || other.message == message)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}


@override
int get hashCode => Object.hash(runtimeType,role,message,sentAt);

@override
String toString() {
  return 'ChatMessage.receivingMessage(role: $role, message: $message, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageReceivingCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageReceivingCopyWith(_ChatMessageReceiving value, $Res Function(_ChatMessageReceiving) _then) = __$ChatMessageReceivingCopyWithImpl;
@override @useResult
$Res call({
 Role role, String message,@DateTimeToTimestampConverter() DateTime? sentAt
});




}
/// @nodoc
class __$ChatMessageReceivingCopyWithImpl<$Res>
    implements _$ChatMessageReceivingCopyWith<$Res> {
  __$ChatMessageReceivingCopyWithImpl(this._self, this._then);

  final _ChatMessageReceiving _self;
  final $Res Function(_ChatMessageReceiving) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? message = null,Object? sentAt = freezed,}) {
  return _then(_ChatMessageReceiving(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _ChatMessageException implements ChatMessage {
  const _ChatMessageException({required this.role, required this.message, @DateTimeToTimestampConverter() this.sentAt});
  

@override final  Role role;
@override final  String message;
@override@DateTimeToTimestampConverter() final  DateTime? sentAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageExceptionCopyWith<_ChatMessageException> get copyWith => __$ChatMessageExceptionCopyWithImpl<_ChatMessageException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageException&&(identical(other.role, role) || other.role == role)&&(identical(other.message, message) || other.message == message)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}


@override
int get hashCode => Object.hash(runtimeType,role,message,sentAt);

@override
String toString() {
  return 'ChatMessage.exception(role: $role, message: $message, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageExceptionCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageExceptionCopyWith(_ChatMessageException value, $Res Function(_ChatMessageException) _then) = __$ChatMessageExceptionCopyWithImpl;
@override @useResult
$Res call({
 Role role, String message,@DateTimeToTimestampConverter() DateTime? sentAt
});




}
/// @nodoc
class __$ChatMessageExceptionCopyWithImpl<$Res>
    implements _$ChatMessageExceptionCopyWith<$Res> {
  __$ChatMessageExceptionCopyWithImpl(this._self, this._then);

  final _ChatMessageException _self;
  final $Res Function(_ChatMessageException) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? message = null,Object? sentAt = freezed,}) {
  return _then(_ChatMessageException(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as Role,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$ChatState {

 ChatSessionRepo get session; bool get isLoading; List<ChatMessage> get messages;@CreatedAtField() DateTime? get createdAt;@UpdatedAtField() DateTime? get updatedAt;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&(identical(other.session, session) || other.session == session)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,session,isLoading,const DeepCollectionEquality().hash(messages),createdAt,updatedAt);

@override
String toString() {
  return 'ChatState(session: $session, isLoading: $isLoading, messages: $messages, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 ChatSessionRepo session, bool isLoading, List<ChatMessage> messages,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? isLoading = null,Object? messages = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ChatSessionRepo,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc


class _ChatState implements ChatState {
  const _ChatState({required this.session, this.isLoading = false, final  List<ChatMessage> messages = const [], @CreatedAtField() this.createdAt, @UpdatedAtField() this.updatedAt}): _messages = messages;
  

@override final  ChatSessionRepo session;
@override@JsonKey() final  bool isLoading;
 final  List<ChatMessage> _messages;
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@CreatedAtField() final  DateTime? createdAt;
@override@UpdatedAtField() final  DateTime? updatedAt;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&(identical(other.session, session) || other.session == session)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,session,isLoading,const DeepCollectionEquality().hash(_messages),createdAt,updatedAt);

@override
String toString() {
  return 'ChatState(session: $session, isLoading: $isLoading, messages: $messages, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 ChatSessionRepo session, bool isLoading, List<ChatMessage> messages,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? isLoading = null,Object? messages = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ChatState(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ChatSessionRepo,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
