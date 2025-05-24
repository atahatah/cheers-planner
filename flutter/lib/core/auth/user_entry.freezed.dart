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

 String? get id;@NullableDateTimeToTimestampConverter() DateTime? get birthday;@CreatedAtField() DateTime? get createdAt;@UpdatedAtField() DateTime? get updatedAt;
/// Create a copy of UserEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntryCopyWith<UserEntry> get copyWith => _$UserEntryCopyWithImpl<UserEntry>(this as UserEntry, _$identity);

  /// Serializes this UserEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,birthday,createdAt,updatedAt);

@override
String toString() {
  return 'UserEntry(id: $id, birthday: $birthday, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserEntryCopyWith<$Res>  {
  factory $UserEntryCopyWith(UserEntry value, $Res Function(UserEntry) _then) = _$UserEntryCopyWithImpl;
@useResult
$Res call({
 String? id,@NullableDateTimeToTimestampConverter() DateTime? birthday,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? birthday = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserEntry implements UserEntry {
  const _UserEntry({this.id, @NullableDateTimeToTimestampConverter() this.birthday, @CreatedAtField() this.createdAt, @UpdatedAtField() this.updatedAt});
  factory _UserEntry.fromJson(Map<String, dynamic> json) => _$UserEntryFromJson(json);

@override final  String? id;
@override@NullableDateTimeToTimestampConverter() final  DateTime? birthday;
@override@CreatedAtField() final  DateTime? createdAt;
@override@UpdatedAtField() final  DateTime? updatedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,birthday,createdAt,updatedAt);

@override
String toString() {
  return 'UserEntry(id: $id, birthday: $birthday, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserEntryCopyWith<$Res> implements $UserEntryCopyWith<$Res> {
  factory _$UserEntryCopyWith(_UserEntry value, $Res Function(_UserEntry) _then) = __$UserEntryCopyWithImpl;
@override @useResult
$Res call({
 String? id,@NullableDateTimeToTimestampConverter() DateTime? birthday,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? birthday = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_UserEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
