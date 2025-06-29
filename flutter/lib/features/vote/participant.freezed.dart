// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventParticipant {

 String? get id; String? get eventId; String get phoneNumber; String? get positionOrGrade; int get desiredBudget;@DateTimeListToTimestampListConverter() List<DateTime> get desiredDateTimes;@GeoPointListToJsonConverter() List<GeoPoint> get desiredLocations; String get allergiesEtc;@CreatedAtField() DateTime? get createdAt;@UpdatedAtField() DateTime? get updatedAt;
/// Create a copy of EventParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventParticipantCopyWith<EventParticipant> get copyWith => _$EventParticipantCopyWithImpl<EventParticipant>(this as EventParticipant, _$identity);

  /// Serializes this EventParticipant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventParticipant&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.positionOrGrade, positionOrGrade) || other.positionOrGrade == positionOrGrade)&&(identical(other.desiredBudget, desiredBudget) || other.desiredBudget == desiredBudget)&&const DeepCollectionEquality().equals(other.desiredDateTimes, desiredDateTimes)&&const DeepCollectionEquality().equals(other.desiredLocations, desiredLocations)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,phoneNumber,positionOrGrade,desiredBudget,const DeepCollectionEquality().hash(desiredDateTimes),const DeepCollectionEquality().hash(desiredLocations),allergiesEtc,createdAt,updatedAt);

@override
String toString() {
  return 'EventParticipant(id: $id, eventId: $eventId, phoneNumber: $phoneNumber, positionOrGrade: $positionOrGrade, desiredBudget: $desiredBudget, desiredDateTimes: $desiredDateTimes, desiredLocations: $desiredLocations, allergiesEtc: $allergiesEtc, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EventParticipantCopyWith<$Res>  {
  factory $EventParticipantCopyWith(EventParticipant value, $Res Function(EventParticipant) _then) = _$EventParticipantCopyWithImpl;
@useResult
$Res call({
 String? id, String? eventId, String phoneNumber, String? positionOrGrade, int desiredBudget,@DateTimeListToTimestampListConverter() List<DateTime> desiredDateTimes,@GeoPointListToJsonConverter() List<GeoPoint> desiredLocations, String allergiesEtc,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class _$EventParticipantCopyWithImpl<$Res>
    implements $EventParticipantCopyWith<$Res> {
  _$EventParticipantCopyWithImpl(this._self, this._then);

  final EventParticipant _self;
  final $Res Function(EventParticipant) _then;

/// Create a copy of EventParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? eventId = freezed,Object? phoneNumber = null,Object? positionOrGrade = freezed,Object? desiredBudget = null,Object? desiredDateTimes = null,Object? desiredLocations = null,Object? allergiesEtc = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,positionOrGrade: freezed == positionOrGrade ? _self.positionOrGrade : positionOrGrade // ignore: cast_nullable_to_non_nullable
as String?,desiredBudget: null == desiredBudget ? _self.desiredBudget : desiredBudget // ignore: cast_nullable_to_non_nullable
as int,desiredDateTimes: null == desiredDateTimes ? _self.desiredDateTimes : desiredDateTimes // ignore: cast_nullable_to_non_nullable
as List<DateTime>,desiredLocations: null == desiredLocations ? _self.desiredLocations : desiredLocations // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EventParticipant implements EventParticipant {
  const _EventParticipant({this.id, this.eventId, required this.phoneNumber, required this.positionOrGrade, required this.desiredBudget, @DateTimeListToTimestampListConverter() required final  List<DateTime> desiredDateTimes, @GeoPointListToJsonConverter() required final  List<GeoPoint> desiredLocations, required this.allergiesEtc, @CreatedAtField() this.createdAt, @UpdatedAtField() this.updatedAt}): _desiredDateTimes = desiredDateTimes,_desiredLocations = desiredLocations;
  factory _EventParticipant.fromJson(Map<String, dynamic> json) => _$EventParticipantFromJson(json);

@override final  String? id;
@override final  String? eventId;
@override final  String phoneNumber;
@override final  String? positionOrGrade;
@override final  int desiredBudget;
 final  List<DateTime> _desiredDateTimes;
@override@DateTimeListToTimestampListConverter() List<DateTime> get desiredDateTimes {
  if (_desiredDateTimes is EqualUnmodifiableListView) return _desiredDateTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_desiredDateTimes);
}

 final  List<GeoPoint> _desiredLocations;
@override@GeoPointListToJsonConverter() List<GeoPoint> get desiredLocations {
  if (_desiredLocations is EqualUnmodifiableListView) return _desiredLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_desiredLocations);
}

@override final  String allergiesEtc;
@override@CreatedAtField() final  DateTime? createdAt;
@override@UpdatedAtField() final  DateTime? updatedAt;

/// Create a copy of EventParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventParticipantCopyWith<_EventParticipant> get copyWith => __$EventParticipantCopyWithImpl<_EventParticipant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventParticipantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventParticipant&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.positionOrGrade, positionOrGrade) || other.positionOrGrade == positionOrGrade)&&(identical(other.desiredBudget, desiredBudget) || other.desiredBudget == desiredBudget)&&const DeepCollectionEquality().equals(other._desiredDateTimes, _desiredDateTimes)&&const DeepCollectionEquality().equals(other._desiredLocations, _desiredLocations)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,phoneNumber,positionOrGrade,desiredBudget,const DeepCollectionEquality().hash(_desiredDateTimes),const DeepCollectionEquality().hash(_desiredLocations),allergiesEtc,createdAt,updatedAt);

@override
String toString() {
  return 'EventParticipant(id: $id, eventId: $eventId, phoneNumber: $phoneNumber, positionOrGrade: $positionOrGrade, desiredBudget: $desiredBudget, desiredDateTimes: $desiredDateTimes, desiredLocations: $desiredLocations, allergiesEtc: $allergiesEtc, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EventParticipantCopyWith<$Res> implements $EventParticipantCopyWith<$Res> {
  factory _$EventParticipantCopyWith(_EventParticipant value, $Res Function(_EventParticipant) _then) = __$EventParticipantCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? eventId, String phoneNumber, String? positionOrGrade, int desiredBudget,@DateTimeListToTimestampListConverter() List<DateTime> desiredDateTimes,@GeoPointListToJsonConverter() List<GeoPoint> desiredLocations, String allergiesEtc,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class __$EventParticipantCopyWithImpl<$Res>
    implements _$EventParticipantCopyWith<$Res> {
  __$EventParticipantCopyWithImpl(this._self, this._then);

  final _EventParticipant _self;
  final $Res Function(_EventParticipant) _then;

/// Create a copy of EventParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? eventId = freezed,Object? phoneNumber = null,Object? positionOrGrade = freezed,Object? desiredBudget = null,Object? desiredDateTimes = null,Object? desiredLocations = null,Object? allergiesEtc = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_EventParticipant(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,positionOrGrade: freezed == positionOrGrade ? _self.positionOrGrade : positionOrGrade // ignore: cast_nullable_to_non_nullable
as String?,desiredBudget: null == desiredBudget ? _self.desiredBudget : desiredBudget // ignore: cast_nullable_to_non_nullable
as int,desiredDateTimes: null == desiredDateTimes ? _self._desiredDateTimes : desiredDateTimes // ignore: cast_nullable_to_non_nullable
as List<DateTime>,desiredLocations: null == desiredLocations ? _self._desiredLocations : desiredLocations // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
