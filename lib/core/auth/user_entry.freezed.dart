// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserEntry {

 String get id; String get name; String get email; String get photoUrl; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of UserEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntryCopyWith<UserEntry> get copyWith => _$UserEntryCopyWithImpl<UserEntry>(this as UserEntry, _$identity);

  /// Serializes this UserEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,photoUrl,createdAt,updatedAt);

@override
String toString() {
  return 'UserEntry(id: $id, name: $name, email: $email, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserEntryCopyWith<$Res>  {
  factory $UserEntryCopyWith(UserEntry value, $Res Function(UserEntry) _then) = _$UserEntryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String photoUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$UserEntryCopyWithImpl<$Res>
    implements $UserEntryCopyWith<$Res> {
  _$UserEntryCopyWithImpl(this._self, this._then);

  final UserEntry _self;
  final $Res Function(UserEntry) _then;

/// Create a copy of UserEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? photoUrl = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserEntry implements UserEntry {
  const _UserEntry({required this.id, required this.name, required this.email, required this.photoUrl, required this.createdAt, required this.updatedAt});
  factory _UserEntry.fromJson(Map<String, dynamic> json) => _$UserEntryFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String photoUrl;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of UserEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntryCopyWith<_UserEntry> get copyWith => __$UserEntryCopyWithImpl<_UserEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,photoUrl,createdAt,updatedAt);

@override
String toString() {
  return 'UserEntry(id: $id, name: $name, email: $email, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserEntryCopyWith<$Res> implements $UserEntryCopyWith<$Res> {
  factory _$UserEntryCopyWith(_UserEntry value, $Res Function(_UserEntry) _then) = __$UserEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String photoUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$UserEntryCopyWithImpl<$Res>
    implements _$UserEntryCopyWith<$Res> {
  __$UserEntryCopyWithImpl(this._self, this._then);

  final _UserEntry _self;
  final $Res Function(_UserEntry) _then;

/// Create a copy of UserEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? photoUrl = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_UserEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
