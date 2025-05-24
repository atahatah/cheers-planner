// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppAuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppAuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppAuthState()';
}


}

/// @nodoc
class $AppAuthStateCopyWith<$Res>  {
$AppAuthStateCopyWith(AppAuthState _, $Res Function(AppAuthState) __);
}


/// @nodoc


class SignedIn implements AppAuthState {
  const SignedIn({required this.user, required this.userEntry});
  

 final  User user;
 final  UserEntry userEntry;

/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignedInCopyWith<SignedIn> get copyWith => _$SignedInCopyWithImpl<SignedIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignedIn&&(identical(other.user, user) || other.user == user)&&(identical(other.userEntry, userEntry) || other.userEntry == userEntry));
}


@override
int get hashCode => Object.hash(runtimeType,user,userEntry);

@override
String toString() {
  return 'AppAuthState.signedIn(user: $user, userEntry: $userEntry)';
}


}

/// @nodoc
abstract mixin class $SignedInCopyWith<$Res> implements $AppAuthStateCopyWith<$Res> {
  factory $SignedInCopyWith(SignedIn value, $Res Function(SignedIn) _then) = _$SignedInCopyWithImpl;
@useResult
$Res call({
 User user, UserEntry userEntry
});


$UserEntryCopyWith<$Res> get userEntry;

}
/// @nodoc
class _$SignedInCopyWithImpl<$Res>
    implements $SignedInCopyWith<$Res> {
  _$SignedInCopyWithImpl(this._self, this._then);

  final SignedIn _self;
  final $Res Function(SignedIn) _then;

/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? userEntry = null,}) {
  return _then(SignedIn(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,userEntry: null == userEntry ? _self.userEntry : userEntry // ignore: cast_nullable_to_non_nullable
as UserEntry,
  ));
}

/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntryCopyWith<$Res> get userEntry {
  
  return $UserEntryCopyWith<$Res>(_self.userEntry, (value) {
    return _then(_self.copyWith(userEntry: value));
  });
}
}

/// @nodoc


class NotRegistered implements AppAuthState {
  const NotRegistered({required this.user});
  

 final  User user;

/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotRegisteredCopyWith<NotRegistered> get copyWith => _$NotRegisteredCopyWithImpl<NotRegistered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotRegistered&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AppAuthState.notRegistered(user: $user)';
}


}

/// @nodoc
abstract mixin class $NotRegisteredCopyWith<$Res> implements $AppAuthStateCopyWith<$Res> {
  factory $NotRegisteredCopyWith(NotRegistered value, $Res Function(NotRegistered) _then) = _$NotRegisteredCopyWithImpl;
@useResult
$Res call({
 User user
});




}
/// @nodoc
class _$NotRegisteredCopyWithImpl<$Res>
    implements $NotRegisteredCopyWith<$Res> {
  _$NotRegisteredCopyWithImpl(this._self, this._then);

  final NotRegistered _self;
  final $Res Function(NotRegistered) _then;

/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(NotRegistered(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}


}

/// @nodoc


class NotSignedIn implements AppAuthState {
  const NotSignedIn();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotSignedIn);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppAuthState.notSignedIn()';
}


}




// dart format on
