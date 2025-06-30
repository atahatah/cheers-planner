// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Event {

 String get id; List<String> get organizerId; List<String> get participantId; String get eventName;@DateTimeToTimestampConverter() DateTime get dueDate; int get minutes; int get budgetUpperLimit; String get purpose; List<String> get fixedQuestion; List<CandidateDateTime>? get candidateDateTimes; Map<String, CandidateArea>? get candidateAreas; String? get aiRecArea;@NullableDateTimeToTimestampConverter() DateTime? get aiRecDate; List<String>? get aiRecStore;@CreatedAtField() DateTime? get createdAt;@UpdatedAtField() DateTime? get updatedAt;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.organizerId, organizerId)&&const DeepCollectionEquality().equals(other.participantId, participantId)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.budgetUpperLimit, budgetUpperLimit) || other.budgetUpperLimit == budgetUpperLimit)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&const DeepCollectionEquality().equals(other.fixedQuestion, fixedQuestion)&&const DeepCollectionEquality().equals(other.candidateDateTimes, candidateDateTimes)&&const DeepCollectionEquality().equals(other.candidateAreas, candidateAreas)&&(identical(other.aiRecArea, aiRecArea) || other.aiRecArea == aiRecArea)&&(identical(other.aiRecDate, aiRecDate) || other.aiRecDate == aiRecDate)&&const DeepCollectionEquality().equals(other.aiRecStore, aiRecStore)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(organizerId),const DeepCollectionEquality().hash(participantId),eventName,dueDate,minutes,budgetUpperLimit,purpose,const DeepCollectionEquality().hash(fixedQuestion),const DeepCollectionEquality().hash(candidateDateTimes),const DeepCollectionEquality().hash(candidateAreas),aiRecArea,aiRecDate,const DeepCollectionEquality().hash(aiRecStore),createdAt,updatedAt);

@override
String toString() {
  return 'Event(id: $id, organizerId: $organizerId, participantId: $participantId, eventName: $eventName, dueDate: $dueDate, minutes: $minutes, budgetUpperLimit: $budgetUpperLimit, purpose: $purpose, fixedQuestion: $fixedQuestion, candidateDateTimes: $candidateDateTimes, candidateAreas: $candidateAreas, aiRecArea: $aiRecArea, aiRecDate: $aiRecDate, aiRecStore: $aiRecStore, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, List<String> organizerId, List<String> participantId, String eventName,@DateTimeToTimestampConverter() DateTime dueDate, int minutes, int budgetUpperLimit, String purpose, List<String> fixedQuestion, List<CandidateDateTime>? candidateDateTimes, Map<String, CandidateArea>? candidateAreas, String? aiRecArea,@NullableDateTimeToTimestampConverter() DateTime? aiRecDate, List<String>? aiRecStore,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? organizerId = null,Object? participantId = null,Object? eventName = null,Object? dueDate = null,Object? minutes = null,Object? budgetUpperLimit = null,Object? purpose = null,Object? fixedQuestion = null,Object? candidateDateTimes = freezed,Object? candidateAreas = freezed,Object? aiRecArea = freezed,Object? aiRecDate = freezed,Object? aiRecStore = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as List<String>,participantId: null == participantId ? _self.participantId : participantId // ignore: cast_nullable_to_non_nullable
as List<String>,eventName: null == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,budgetUpperLimit: null == budgetUpperLimit ? _self.budgetUpperLimit : budgetUpperLimit // ignore: cast_nullable_to_non_nullable
as int,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,fixedQuestion: null == fixedQuestion ? _self.fixedQuestion : fixedQuestion // ignore: cast_nullable_to_non_nullable
as List<String>,candidateDateTimes: freezed == candidateDateTimes ? _self.candidateDateTimes : candidateDateTimes // ignore: cast_nullable_to_non_nullable
as List<CandidateDateTime>?,candidateAreas: freezed == candidateAreas ? _self.candidateAreas : candidateAreas // ignore: cast_nullable_to_non_nullable
as Map<String, CandidateArea>?,aiRecArea: freezed == aiRecArea ? _self.aiRecArea : aiRecArea // ignore: cast_nullable_to_non_nullable
as String?,aiRecDate: freezed == aiRecDate ? _self.aiRecDate : aiRecDate // ignore: cast_nullable_to_non_nullable
as DateTime?,aiRecStore: freezed == aiRecStore ? _self.aiRecStore : aiRecStore // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({required this.id, required final  List<String> organizerId, required final  List<String> participantId, required this.eventName, @DateTimeToTimestampConverter() required this.dueDate, required this.minutes, required this.budgetUpperLimit, required this.purpose, required final  List<String> fixedQuestion, final  List<CandidateDateTime>? candidateDateTimes, final  Map<String, CandidateArea>? candidateAreas, this.aiRecArea, @NullableDateTimeToTimestampConverter() this.aiRecDate, final  List<String>? aiRecStore, @CreatedAtField() this.createdAt, @UpdatedAtField() this.updatedAt}): _organizerId = organizerId,_participantId = participantId,_fixedQuestion = fixedQuestion,_candidateDateTimes = candidateDateTimes,_candidateAreas = candidateAreas,_aiRecStore = aiRecStore;
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  String id;
 final  List<String> _organizerId;
@override List<String> get organizerId {
  if (_organizerId is EqualUnmodifiableListView) return _organizerId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_organizerId);
}

 final  List<String> _participantId;
@override List<String> get participantId {
  if (_participantId is EqualUnmodifiableListView) return _participantId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantId);
}

@override final  String eventName;
@override@DateTimeToTimestampConverter() final  DateTime dueDate;
@override final  int minutes;
@override final  int budgetUpperLimit;
@override final  String purpose;
 final  List<String> _fixedQuestion;
@override List<String> get fixedQuestion {
  if (_fixedQuestion is EqualUnmodifiableListView) return _fixedQuestion;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fixedQuestion);
}

 final  List<CandidateDateTime>? _candidateDateTimes;
@override List<CandidateDateTime>? get candidateDateTimes {
  final value = _candidateDateTimes;
  if (value == null) return null;
  if (_candidateDateTimes is EqualUnmodifiableListView) return _candidateDateTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, CandidateArea>? _candidateAreas;
@override Map<String, CandidateArea>? get candidateAreas {
  final value = _candidateAreas;
  if (value == null) return null;
  if (_candidateAreas is EqualUnmodifiableMapView) return _candidateAreas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? aiRecArea;
@override@NullableDateTimeToTimestampConverter() final  DateTime? aiRecDate;
 final  List<String>? _aiRecStore;
@override List<String>? get aiRecStore {
  final value = _aiRecStore;
  if (value == null) return null;
  if (_aiRecStore is EqualUnmodifiableListView) return _aiRecStore;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@CreatedAtField() final  DateTime? createdAt;
@override@UpdatedAtField() final  DateTime? updatedAt;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._organizerId, _organizerId)&&const DeepCollectionEquality().equals(other._participantId, _participantId)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.budgetUpperLimit, budgetUpperLimit) || other.budgetUpperLimit == budgetUpperLimit)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&const DeepCollectionEquality().equals(other._fixedQuestion, _fixedQuestion)&&const DeepCollectionEquality().equals(other._candidateDateTimes, _candidateDateTimes)&&const DeepCollectionEquality().equals(other._candidateAreas, _candidateAreas)&&(identical(other.aiRecArea, aiRecArea) || other.aiRecArea == aiRecArea)&&(identical(other.aiRecDate, aiRecDate) || other.aiRecDate == aiRecDate)&&const DeepCollectionEquality().equals(other._aiRecStore, _aiRecStore)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_organizerId),const DeepCollectionEquality().hash(_participantId),eventName,dueDate,minutes,budgetUpperLimit,purpose,const DeepCollectionEquality().hash(_fixedQuestion),const DeepCollectionEquality().hash(_candidateDateTimes),const DeepCollectionEquality().hash(_candidateAreas),aiRecArea,aiRecDate,const DeepCollectionEquality().hash(_aiRecStore),createdAt,updatedAt);

@override
String toString() {
  return 'Event(id: $id, organizerId: $organizerId, participantId: $participantId, eventName: $eventName, dueDate: $dueDate, minutes: $minutes, budgetUpperLimit: $budgetUpperLimit, purpose: $purpose, fixedQuestion: $fixedQuestion, candidateDateTimes: $candidateDateTimes, candidateAreas: $candidateAreas, aiRecArea: $aiRecArea, aiRecDate: $aiRecDate, aiRecStore: $aiRecStore, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, List<String> organizerId, List<String> participantId, String eventName,@DateTimeToTimestampConverter() DateTime dueDate, int minutes, int budgetUpperLimit, String purpose, List<String> fixedQuestion, List<CandidateDateTime>? candidateDateTimes, Map<String, CandidateArea>? candidateAreas, String? aiRecArea,@NullableDateTimeToTimestampConverter() DateTime? aiRecDate, List<String>? aiRecStore,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? organizerId = null,Object? participantId = null,Object? eventName = null,Object? dueDate = null,Object? minutes = null,Object? budgetUpperLimit = null,Object? purpose = null,Object? fixedQuestion = null,Object? candidateDateTimes = freezed,Object? candidateAreas = freezed,Object? aiRecArea = freezed,Object? aiRecDate = freezed,Object? aiRecStore = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self._organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as List<String>,participantId: null == participantId ? _self._participantId : participantId // ignore: cast_nullable_to_non_nullable
as List<String>,eventName: null == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,budgetUpperLimit: null == budgetUpperLimit ? _self.budgetUpperLimit : budgetUpperLimit // ignore: cast_nullable_to_non_nullable
as int,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,fixedQuestion: null == fixedQuestion ? _self._fixedQuestion : fixedQuestion // ignore: cast_nullable_to_non_nullable
as List<String>,candidateDateTimes: freezed == candidateDateTimes ? _self._candidateDateTimes : candidateDateTimes // ignore: cast_nullable_to_non_nullable
as List<CandidateDateTime>?,candidateAreas: freezed == candidateAreas ? _self._candidateAreas : candidateAreas // ignore: cast_nullable_to_non_nullable
as Map<String, CandidateArea>?,aiRecArea: freezed == aiRecArea ? _self.aiRecArea : aiRecArea // ignore: cast_nullable_to_non_nullable
as String?,aiRecDate: freezed == aiRecDate ? _self.aiRecDate : aiRecDate // ignore: cast_nullable_to_non_nullable
as DateTime?,aiRecStore: freezed == aiRecStore ? _self._aiRecStore : aiRecStore // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CandidateDateTime {

@DateTimeToTimestampConverter() DateTime get start;
/// Create a copy of CandidateDateTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateDateTimeCopyWith<CandidateDateTime> get copyWith => _$CandidateDateTimeCopyWithImpl<CandidateDateTime>(this as CandidateDateTime, _$identity);

  /// Serializes this CandidateDateTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateDateTime&&(identical(other.start, start) || other.start == start));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start);

@override
String toString() {
  return 'CandidateDateTime(start: $start)';
}


}

/// @nodoc
abstract mixin class $CandidateDateTimeCopyWith<$Res>  {
  factory $CandidateDateTimeCopyWith(CandidateDateTime value, $Res Function(CandidateDateTime) _then) = _$CandidateDateTimeCopyWithImpl;
@useResult
$Res call({
@DateTimeToTimestampConverter() DateTime start
});




}
/// @nodoc
class _$CandidateDateTimeCopyWithImpl<$Res>
    implements $CandidateDateTimeCopyWith<$Res> {
  _$CandidateDateTimeCopyWithImpl(this._self, this._then);

  final CandidateDateTime _self;
  final $Res Function(CandidateDateTime) _then;

/// Create a copy of CandidateDateTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CandidateDateTime implements CandidateDateTime {
  const _CandidateDateTime({@DateTimeToTimestampConverter() required this.start});
  factory _CandidateDateTime.fromJson(Map<String, dynamic> json) => _$CandidateDateTimeFromJson(json);

@override@DateTimeToTimestampConverter() final  DateTime start;

/// Create a copy of CandidateDateTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateDateTimeCopyWith<_CandidateDateTime> get copyWith => __$CandidateDateTimeCopyWithImpl<_CandidateDateTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateDateTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateDateTime&&(identical(other.start, start) || other.start == start));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start);

@override
String toString() {
  return 'CandidateDateTime(start: $start)';
}


}

/// @nodoc
abstract mixin class _$CandidateDateTimeCopyWith<$Res> implements $CandidateDateTimeCopyWith<$Res> {
  factory _$CandidateDateTimeCopyWith(_CandidateDateTime value, $Res Function(_CandidateDateTime) _then) = __$CandidateDateTimeCopyWithImpl;
@override @useResult
$Res call({
@DateTimeToTimestampConverter() DateTime start
});




}
/// @nodoc
class __$CandidateDateTimeCopyWithImpl<$Res>
    implements _$CandidateDateTimeCopyWith<$Res> {
  __$CandidateDateTimeCopyWithImpl(this._self, this._then);

  final _CandidateDateTime _self;
  final $Res Function(_CandidateDateTime) _then;

/// Create a copy of CandidateDateTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,}) {
  return _then(_CandidateDateTime(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CandidateArea {

@_GeoPointConverter() GeoPoint get center; double get radius;
/// Create a copy of CandidateArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateAreaCopyWith<CandidateArea> get copyWith => _$CandidateAreaCopyWithImpl<CandidateArea>(this as CandidateArea, _$identity);

  /// Serializes this CandidateArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateArea&&(identical(other.center, center) || other.center == center)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,radius);

@override
String toString() {
  return 'CandidateArea(center: $center, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $CandidateAreaCopyWith<$Res>  {
  factory $CandidateAreaCopyWith(CandidateArea value, $Res Function(CandidateArea) _then) = _$CandidateAreaCopyWithImpl;
@useResult
$Res call({
@_GeoPointConverter() GeoPoint center, double radius
});




}
/// @nodoc
class _$CandidateAreaCopyWithImpl<$Res>
    implements $CandidateAreaCopyWith<$Res> {
  _$CandidateAreaCopyWithImpl(this._self, this._then);

  final CandidateArea _self;
  final $Res Function(CandidateArea) _then;

/// Create a copy of CandidateArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? center = null,Object? radius = null,}) {
  return _then(_self.copyWith(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as GeoPoint,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CandidateArea implements CandidateArea {
  const _CandidateArea({@_GeoPointConverter() required this.center, required this.radius});
  factory _CandidateArea.fromJson(Map<String, dynamic> json) => _$CandidateAreaFromJson(json);

@override@_GeoPointConverter() final  GeoPoint center;
@override final  double radius;

/// Create a copy of CandidateArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateAreaCopyWith<_CandidateArea> get copyWith => __$CandidateAreaCopyWithImpl<_CandidateArea>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateAreaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateArea&&(identical(other.center, center) || other.center == center)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,radius);

@override
String toString() {
  return 'CandidateArea(center: $center, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$CandidateAreaCopyWith<$Res> implements $CandidateAreaCopyWith<$Res> {
  factory _$CandidateAreaCopyWith(_CandidateArea value, $Res Function(_CandidateArea) _then) = __$CandidateAreaCopyWithImpl;
@override @useResult
$Res call({
@_GeoPointConverter() GeoPoint center, double radius
});




}
/// @nodoc
class __$CandidateAreaCopyWithImpl<$Res>
    implements _$CandidateAreaCopyWith<$Res> {
  __$CandidateAreaCopyWithImpl(this._self, this._then);

  final _CandidateArea _self;
  final $Res Function(_CandidateArea) _then;

/// Create a copy of CandidateArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? center = null,Object? radius = null,}) {
  return _then(_CandidateArea(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as GeoPoint,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Participant {

 String get id; String get name; String get phoneNumber; String get positionOrGrade; int get desiredBudget;@_DateTimeListConverter() List<DateTime> get desiredDates; List<String> get desiredLocations; String get allergiesEtc;@DateTimeToTimestampConverter() DateTime get submittedAt; List<FixedQuestionAnswer>? get fixedQuestionAnswers; List<CustomQuestionAnswer>? get customQuestionAnswers;@CreatedAtField() DateTime? get createdAt;@UpdatedAtField() DateTime? get updatedAt;
/// Create a copy of Participant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantCopyWith<Participant> get copyWith => _$ParticipantCopyWithImpl<Participant>(this as Participant, _$identity);

  /// Serializes this Participant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Participant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.positionOrGrade, positionOrGrade) || other.positionOrGrade == positionOrGrade)&&(identical(other.desiredBudget, desiredBudget) || other.desiredBudget == desiredBudget)&&const DeepCollectionEquality().equals(other.desiredDates, desiredDates)&&const DeepCollectionEquality().equals(other.desiredLocations, desiredLocations)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other.fixedQuestionAnswers, fixedQuestionAnswers)&&const DeepCollectionEquality().equals(other.customQuestionAnswers, customQuestionAnswers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber,positionOrGrade,desiredBudget,const DeepCollectionEquality().hash(desiredDates),const DeepCollectionEquality().hash(desiredLocations),allergiesEtc,submittedAt,const DeepCollectionEquality().hash(fixedQuestionAnswers),const DeepCollectionEquality().hash(customQuestionAnswers),createdAt,updatedAt);

@override
String toString() {
  return 'Participant(id: $id, name: $name, phoneNumber: $phoneNumber, positionOrGrade: $positionOrGrade, desiredBudget: $desiredBudget, desiredDates: $desiredDates, desiredLocations: $desiredLocations, allergiesEtc: $allergiesEtc, submittedAt: $submittedAt, fixedQuestionAnswers: $fixedQuestionAnswers, customQuestionAnswers: $customQuestionAnswers, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ParticipantCopyWith<$Res>  {
  factory $ParticipantCopyWith(Participant value, $Res Function(Participant) _then) = _$ParticipantCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phoneNumber, String positionOrGrade, int desiredBudget,@_DateTimeListConverter() List<DateTime> desiredDates, List<String> desiredLocations, String allergiesEtc,@DateTimeToTimestampConverter() DateTime submittedAt, List<FixedQuestionAnswer>? fixedQuestionAnswers, List<CustomQuestionAnswer>? customQuestionAnswers,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class _$ParticipantCopyWithImpl<$Res>
    implements $ParticipantCopyWith<$Res> {
  _$ParticipantCopyWithImpl(this._self, this._then);

  final Participant _self;
  final $Res Function(Participant) _then;

/// Create a copy of Participant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? positionOrGrade = null,Object? desiredBudget = null,Object? desiredDates = null,Object? desiredLocations = null,Object? allergiesEtc = null,Object? submittedAt = null,Object? fixedQuestionAnswers = freezed,Object? customQuestionAnswers = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,positionOrGrade: null == positionOrGrade ? _self.positionOrGrade : positionOrGrade // ignore: cast_nullable_to_non_nullable
as String,desiredBudget: null == desiredBudget ? _self.desiredBudget : desiredBudget // ignore: cast_nullable_to_non_nullable
as int,desiredDates: null == desiredDates ? _self.desiredDates : desiredDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,desiredLocations: null == desiredLocations ? _self.desiredLocations : desiredLocations // ignore: cast_nullable_to_non_nullable
as List<String>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,fixedQuestionAnswers: freezed == fixedQuestionAnswers ? _self.fixedQuestionAnswers : fixedQuestionAnswers // ignore: cast_nullable_to_non_nullable
as List<FixedQuestionAnswer>?,customQuestionAnswers: freezed == customQuestionAnswers ? _self.customQuestionAnswers : customQuestionAnswers // ignore: cast_nullable_to_non_nullable
as List<CustomQuestionAnswer>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Participant implements Participant {
  const _Participant({required this.id, required this.name, required this.phoneNumber, required this.positionOrGrade, required this.desiredBudget, @_DateTimeListConverter() required final  List<DateTime> desiredDates, required final  List<String> desiredLocations, required this.allergiesEtc, @DateTimeToTimestampConverter() required this.submittedAt, final  List<FixedQuestionAnswer>? fixedQuestionAnswers, final  List<CustomQuestionAnswer>? customQuestionAnswers, @CreatedAtField() this.createdAt, @UpdatedAtField() this.updatedAt}): _desiredDates = desiredDates,_desiredLocations = desiredLocations,_fixedQuestionAnswers = fixedQuestionAnswers,_customQuestionAnswers = customQuestionAnswers;
  factory _Participant.fromJson(Map<String, dynamic> json) => _$ParticipantFromJson(json);

@override final  String id;
@override final  String name;
@override final  String phoneNumber;
@override final  String positionOrGrade;
@override final  int desiredBudget;
 final  List<DateTime> _desiredDates;
@override@_DateTimeListConverter() List<DateTime> get desiredDates {
  if (_desiredDates is EqualUnmodifiableListView) return _desiredDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_desiredDates);
}

 final  List<String> _desiredLocations;
@override List<String> get desiredLocations {
  if (_desiredLocations is EqualUnmodifiableListView) return _desiredLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_desiredLocations);
}

@override final  String allergiesEtc;
@override@DateTimeToTimestampConverter() final  DateTime submittedAt;
 final  List<FixedQuestionAnswer>? _fixedQuestionAnswers;
@override List<FixedQuestionAnswer>? get fixedQuestionAnswers {
  final value = _fixedQuestionAnswers;
  if (value == null) return null;
  if (_fixedQuestionAnswers is EqualUnmodifiableListView) return _fixedQuestionAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<CustomQuestionAnswer>? _customQuestionAnswers;
@override List<CustomQuestionAnswer>? get customQuestionAnswers {
  final value = _customQuestionAnswers;
  if (value == null) return null;
  if (_customQuestionAnswers is EqualUnmodifiableListView) return _customQuestionAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@CreatedAtField() final  DateTime? createdAt;
@override@UpdatedAtField() final  DateTime? updatedAt;

/// Create a copy of Participant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantCopyWith<_Participant> get copyWith => __$ParticipantCopyWithImpl<_Participant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParticipantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Participant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.positionOrGrade, positionOrGrade) || other.positionOrGrade == positionOrGrade)&&(identical(other.desiredBudget, desiredBudget) || other.desiredBudget == desiredBudget)&&const DeepCollectionEquality().equals(other._desiredDates, _desiredDates)&&const DeepCollectionEquality().equals(other._desiredLocations, _desiredLocations)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other._fixedQuestionAnswers, _fixedQuestionAnswers)&&const DeepCollectionEquality().equals(other._customQuestionAnswers, _customQuestionAnswers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber,positionOrGrade,desiredBudget,const DeepCollectionEquality().hash(_desiredDates),const DeepCollectionEquality().hash(_desiredLocations),allergiesEtc,submittedAt,const DeepCollectionEquality().hash(_fixedQuestionAnswers),const DeepCollectionEquality().hash(_customQuestionAnswers),createdAt,updatedAt);

@override
String toString() {
  return 'Participant(id: $id, name: $name, phoneNumber: $phoneNumber, positionOrGrade: $positionOrGrade, desiredBudget: $desiredBudget, desiredDates: $desiredDates, desiredLocations: $desiredLocations, allergiesEtc: $allergiesEtc, submittedAt: $submittedAt, fixedQuestionAnswers: $fixedQuestionAnswers, customQuestionAnswers: $customQuestionAnswers, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ParticipantCopyWith<$Res> implements $ParticipantCopyWith<$Res> {
  factory _$ParticipantCopyWith(_Participant value, $Res Function(_Participant) _then) = __$ParticipantCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phoneNumber, String positionOrGrade, int desiredBudget,@_DateTimeListConverter() List<DateTime> desiredDates, List<String> desiredLocations, String allergiesEtc,@DateTimeToTimestampConverter() DateTime submittedAt, List<FixedQuestionAnswer>? fixedQuestionAnswers, List<CustomQuestionAnswer>? customQuestionAnswers,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class __$ParticipantCopyWithImpl<$Res>
    implements _$ParticipantCopyWith<$Res> {
  __$ParticipantCopyWithImpl(this._self, this._then);

  final _Participant _self;
  final $Res Function(_Participant) _then;

/// Create a copy of Participant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? positionOrGrade = null,Object? desiredBudget = null,Object? desiredDates = null,Object? desiredLocations = null,Object? allergiesEtc = null,Object? submittedAt = null,Object? fixedQuestionAnswers = freezed,Object? customQuestionAnswers = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Participant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,positionOrGrade: null == positionOrGrade ? _self.positionOrGrade : positionOrGrade // ignore: cast_nullable_to_non_nullable
as String,desiredBudget: null == desiredBudget ? _self.desiredBudget : desiredBudget // ignore: cast_nullable_to_non_nullable
as int,desiredDates: null == desiredDates ? _self._desiredDates : desiredDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,desiredLocations: null == desiredLocations ? _self._desiredLocations : desiredLocations // ignore: cast_nullable_to_non_nullable
as List<String>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,fixedQuestionAnswers: freezed == fixedQuestionAnswers ? _self._fixedQuestionAnswers : fixedQuestionAnswers // ignore: cast_nullable_to_non_nullable
as List<FixedQuestionAnswer>?,customQuestionAnswers: freezed == customQuestionAnswers ? _self._customQuestionAnswers : customQuestionAnswers // ignore: cast_nullable_to_non_nullable
as List<CustomQuestionAnswer>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$FixedQuestionAnswer {

 String get question; String get answer;
/// Create a copy of FixedQuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FixedQuestionAnswerCopyWith<FixedQuestionAnswer> get copyWith => _$FixedQuestionAnswerCopyWithImpl<FixedQuestionAnswer>(this as FixedQuestionAnswer, _$identity);

  /// Serializes this FixedQuestionAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FixedQuestionAnswer&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,answer);

@override
String toString() {
  return 'FixedQuestionAnswer(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $FixedQuestionAnswerCopyWith<$Res>  {
  factory $FixedQuestionAnswerCopyWith(FixedQuestionAnswer value, $Res Function(FixedQuestionAnswer) _then) = _$FixedQuestionAnswerCopyWithImpl;
@useResult
$Res call({
 String question, String answer
});




}
/// @nodoc
class _$FixedQuestionAnswerCopyWithImpl<$Res>
    implements $FixedQuestionAnswerCopyWith<$Res> {
  _$FixedQuestionAnswerCopyWithImpl(this._self, this._then);

  final FixedQuestionAnswer _self;
  final $Res Function(FixedQuestionAnswer) _then;

/// Create a copy of FixedQuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? answer = null,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FixedQuestionAnswer implements FixedQuestionAnswer {
  const _FixedQuestionAnswer({required this.question, required this.answer});
  factory _FixedQuestionAnswer.fromJson(Map<String, dynamic> json) => _$FixedQuestionAnswerFromJson(json);

@override final  String question;
@override final  String answer;

/// Create a copy of FixedQuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FixedQuestionAnswerCopyWith<_FixedQuestionAnswer> get copyWith => __$FixedQuestionAnswerCopyWithImpl<_FixedQuestionAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FixedQuestionAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FixedQuestionAnswer&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,answer);

@override
String toString() {
  return 'FixedQuestionAnswer(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$FixedQuestionAnswerCopyWith<$Res> implements $FixedQuestionAnswerCopyWith<$Res> {
  factory _$FixedQuestionAnswerCopyWith(_FixedQuestionAnswer value, $Res Function(_FixedQuestionAnswer) _then) = __$FixedQuestionAnswerCopyWithImpl;
@override @useResult
$Res call({
 String question, String answer
});




}
/// @nodoc
class __$FixedQuestionAnswerCopyWithImpl<$Res>
    implements _$FixedQuestionAnswerCopyWith<$Res> {
  __$FixedQuestionAnswerCopyWithImpl(this._self, this._then);

  final _FixedQuestionAnswer _self;
  final $Res Function(_FixedQuestionAnswer) _then;

/// Create a copy of FixedQuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? answer = null,}) {
  return _then(_FixedQuestionAnswer(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CustomQuestionAnswer {

 String get question; String get answer;
/// Create a copy of CustomQuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomQuestionAnswerCopyWith<CustomQuestionAnswer> get copyWith => _$CustomQuestionAnswerCopyWithImpl<CustomQuestionAnswer>(this as CustomQuestionAnswer, _$identity);

  /// Serializes this CustomQuestionAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomQuestionAnswer&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,answer);

@override
String toString() {
  return 'CustomQuestionAnswer(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $CustomQuestionAnswerCopyWith<$Res>  {
  factory $CustomQuestionAnswerCopyWith(CustomQuestionAnswer value, $Res Function(CustomQuestionAnswer) _then) = _$CustomQuestionAnswerCopyWithImpl;
@useResult
$Res call({
 String question, String answer
});




}
/// @nodoc
class _$CustomQuestionAnswerCopyWithImpl<$Res>
    implements $CustomQuestionAnswerCopyWith<$Res> {
  _$CustomQuestionAnswerCopyWithImpl(this._self, this._then);

  final CustomQuestionAnswer _self;
  final $Res Function(CustomQuestionAnswer) _then;

/// Create a copy of CustomQuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? answer = null,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CustomQuestionAnswer implements CustomQuestionAnswer {
  const _CustomQuestionAnswer({required this.question, required this.answer});
  factory _CustomQuestionAnswer.fromJson(Map<String, dynamic> json) => _$CustomQuestionAnswerFromJson(json);

@override final  String question;
@override final  String answer;

/// Create a copy of CustomQuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomQuestionAnswerCopyWith<_CustomQuestionAnswer> get copyWith => __$CustomQuestionAnswerCopyWithImpl<_CustomQuestionAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomQuestionAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomQuestionAnswer&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,answer);

@override
String toString() {
  return 'CustomQuestionAnswer(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$CustomQuestionAnswerCopyWith<$Res> implements $CustomQuestionAnswerCopyWith<$Res> {
  factory _$CustomQuestionAnswerCopyWith(_CustomQuestionAnswer value, $Res Function(_CustomQuestionAnswer) _then) = __$CustomQuestionAnswerCopyWithImpl;
@override @useResult
$Res call({
 String question, String answer
});




}
/// @nodoc
class __$CustomQuestionAnswerCopyWithImpl<$Res>
    implements _$CustomQuestionAnswerCopyWith<$Res> {
  __$CustomQuestionAnswerCopyWithImpl(this._self, this._then);

  final _CustomQuestionAnswer _self;
  final $Res Function(_CustomQuestionAnswer) _then;

/// Create a copy of CustomQuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? answer = null,}) {
  return _then(_CustomQuestionAnswer(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EventResult {

@DateTimeToTimestampConverter() DateTime get optimalDate;@DateTimeToTimestampConverter() DateTime get optimalEnd; List<Restaurant> get restaurants;@CreatedAtField() DateTime? get createdAt;@UpdatedAtField() DateTime? get updatedAt;
/// Create a copy of EventResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventResultCopyWith<EventResult> get copyWith => _$EventResultCopyWithImpl<EventResult>(this as EventResult, _$identity);

  /// Serializes this EventResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventResult&&(identical(other.optimalDate, optimalDate) || other.optimalDate == optimalDate)&&(identical(other.optimalEnd, optimalEnd) || other.optimalEnd == optimalEnd)&&const DeepCollectionEquality().equals(other.restaurants, restaurants)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,optimalDate,optimalEnd,const DeepCollectionEquality().hash(restaurants),createdAt,updatedAt);

@override
String toString() {
  return 'EventResult(optimalDate: $optimalDate, optimalEnd: $optimalEnd, restaurants: $restaurants, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EventResultCopyWith<$Res>  {
  factory $EventResultCopyWith(EventResult value, $Res Function(EventResult) _then) = _$EventResultCopyWithImpl;
@useResult
$Res call({
@DateTimeToTimestampConverter() DateTime optimalDate,@DateTimeToTimestampConverter() DateTime optimalEnd, List<Restaurant> restaurants,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class _$EventResultCopyWithImpl<$Res>
    implements $EventResultCopyWith<$Res> {
  _$EventResultCopyWithImpl(this._self, this._then);

  final EventResult _self;
  final $Res Function(EventResult) _then;

/// Create a copy of EventResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optimalDate = null,Object? optimalEnd = null,Object? restaurants = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
optimalDate: null == optimalDate ? _self.optimalDate : optimalDate // ignore: cast_nullable_to_non_nullable
as DateTime,optimalEnd: null == optimalEnd ? _self.optimalEnd : optimalEnd // ignore: cast_nullable_to_non_nullable
as DateTime,restaurants: null == restaurants ? _self.restaurants : restaurants // ignore: cast_nullable_to_non_nullable
as List<Restaurant>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EventResult implements EventResult {
  const _EventResult({@DateTimeToTimestampConverter() required this.optimalDate, @DateTimeToTimestampConverter() required this.optimalEnd, required final  List<Restaurant> restaurants, @CreatedAtField() this.createdAt, @UpdatedAtField() this.updatedAt}): _restaurants = restaurants;
  factory _EventResult.fromJson(Map<String, dynamic> json) => _$EventResultFromJson(json);

@override@DateTimeToTimestampConverter() final  DateTime optimalDate;
@override@DateTimeToTimestampConverter() final  DateTime optimalEnd;
 final  List<Restaurant> _restaurants;
@override List<Restaurant> get restaurants {
  if (_restaurants is EqualUnmodifiableListView) return _restaurants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_restaurants);
}

@override@CreatedAtField() final  DateTime? createdAt;
@override@UpdatedAtField() final  DateTime? updatedAt;

/// Create a copy of EventResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventResultCopyWith<_EventResult> get copyWith => __$EventResultCopyWithImpl<_EventResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventResult&&(identical(other.optimalDate, optimalDate) || other.optimalDate == optimalDate)&&(identical(other.optimalEnd, optimalEnd) || other.optimalEnd == optimalEnd)&&const DeepCollectionEquality().equals(other._restaurants, _restaurants)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,optimalDate,optimalEnd,const DeepCollectionEquality().hash(_restaurants),createdAt,updatedAt);

@override
String toString() {
  return 'EventResult(optimalDate: $optimalDate, optimalEnd: $optimalEnd, restaurants: $restaurants, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EventResultCopyWith<$Res> implements $EventResultCopyWith<$Res> {
  factory _$EventResultCopyWith(_EventResult value, $Res Function(_EventResult) _then) = __$EventResultCopyWithImpl;
@override @useResult
$Res call({
@DateTimeToTimestampConverter() DateTime optimalDate,@DateTimeToTimestampConverter() DateTime optimalEnd, List<Restaurant> restaurants,@CreatedAtField() DateTime? createdAt,@UpdatedAtField() DateTime? updatedAt
});




}
/// @nodoc
class __$EventResultCopyWithImpl<$Res>
    implements _$EventResultCopyWith<$Res> {
  __$EventResultCopyWithImpl(this._self, this._then);

  final _EventResult _self;
  final $Res Function(_EventResult) _then;

/// Create a copy of EventResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optimalDate = null,Object? optimalEnd = null,Object? restaurants = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_EventResult(
optimalDate: null == optimalDate ? _self.optimalDate : optimalDate // ignore: cast_nullable_to_non_nullable
as DateTime,optimalEnd: null == optimalEnd ? _self.optimalEnd : optimalEnd // ignore: cast_nullable_to_non_nullable
as DateTime,restaurants: null == restaurants ? _self._restaurants : restaurants // ignore: cast_nullable_to_non_nullable
as List<Restaurant>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Restaurant {

 String get name; String get formattedAddress; double get rating; int get priceLevel; String get placeId; String? get menuHighlights; String? get accessInfo; String? get vicinity; Map<String, double>? get location; String? get businessStatus; List<String>? get types; Map<String, dynamic>? get openingHours; List<Map<String, dynamic>>? get photos; int? get userRatingsTotal; Map<String, dynamic>? get drinkingInfo; Map<String, dynamic>? get reviewAnalysis; String? get website; String? get phoneNumber;
/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantCopyWith<Restaurant> get copyWith => _$RestaurantCopyWithImpl<Restaurant>(this as Restaurant, _$identity);

  /// Serializes this Restaurant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Restaurant&&(identical(other.name, name) || other.name == name)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.priceLevel, priceLevel) || other.priceLevel == priceLevel)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.menuHighlights, menuHighlights) || other.menuHighlights == menuHighlights)&&(identical(other.accessInfo, accessInfo) || other.accessInfo == accessInfo)&&(identical(other.vicinity, vicinity) || other.vicinity == vicinity)&&const DeepCollectionEquality().equals(other.location, location)&&(identical(other.businessStatus, businessStatus) || other.businessStatus == businessStatus)&&const DeepCollectionEquality().equals(other.types, types)&&const DeepCollectionEquality().equals(other.openingHours, openingHours)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.userRatingsTotal, userRatingsTotal) || other.userRatingsTotal == userRatingsTotal)&&const DeepCollectionEquality().equals(other.drinkingInfo, drinkingInfo)&&const DeepCollectionEquality().equals(other.reviewAnalysis, reviewAnalysis)&&(identical(other.website, website) || other.website == website)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,formattedAddress,rating,priceLevel,placeId,menuHighlights,accessInfo,vicinity,const DeepCollectionEquality().hash(location),businessStatus,const DeepCollectionEquality().hash(types),const DeepCollectionEquality().hash(openingHours),const DeepCollectionEquality().hash(photos),userRatingsTotal,const DeepCollectionEquality().hash(drinkingInfo),const DeepCollectionEquality().hash(reviewAnalysis),website,phoneNumber);

@override
String toString() {
  return 'Restaurant(name: $name, formattedAddress: $formattedAddress, rating: $rating, priceLevel: $priceLevel, placeId: $placeId, menuHighlights: $menuHighlights, accessInfo: $accessInfo, vicinity: $vicinity, location: $location, businessStatus: $businessStatus, types: $types, openingHours: $openingHours, photos: $photos, userRatingsTotal: $userRatingsTotal, drinkingInfo: $drinkingInfo, reviewAnalysis: $reviewAnalysis, website: $website, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $RestaurantCopyWith<$Res>  {
  factory $RestaurantCopyWith(Restaurant value, $Res Function(Restaurant) _then) = _$RestaurantCopyWithImpl;
@useResult
$Res call({
 String name, String formattedAddress, double rating, int priceLevel, String placeId, String? menuHighlights, String? accessInfo, String? vicinity, Map<String, double>? location, String? businessStatus, List<String>? types, Map<String, dynamic>? openingHours, List<Map<String, dynamic>>? photos, int? userRatingsTotal, Map<String, dynamic>? drinkingInfo, Map<String, dynamic>? reviewAnalysis, String? website, String? phoneNumber
});




}
/// @nodoc
class _$RestaurantCopyWithImpl<$Res>
    implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._self, this._then);

  final Restaurant _self;
  final $Res Function(Restaurant) _then;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? formattedAddress = null,Object? rating = null,Object? priceLevel = null,Object? placeId = null,Object? menuHighlights = freezed,Object? accessInfo = freezed,Object? vicinity = freezed,Object? location = freezed,Object? businessStatus = freezed,Object? types = freezed,Object? openingHours = freezed,Object? photos = freezed,Object? userRatingsTotal = freezed,Object? drinkingInfo = freezed,Object? reviewAnalysis = freezed,Object? website = freezed,Object? phoneNumber = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,formattedAddress: null == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,priceLevel: null == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as int,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,menuHighlights: freezed == menuHighlights ? _self.menuHighlights : menuHighlights // ignore: cast_nullable_to_non_nullable
as String?,accessInfo: freezed == accessInfo ? _self.accessInfo : accessInfo // ignore: cast_nullable_to_non_nullable
as String?,vicinity: freezed == vicinity ? _self.vicinity : vicinity // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,businessStatus: freezed == businessStatus ? _self.businessStatus : businessStatus // ignore: cast_nullable_to_non_nullable
as String?,types: freezed == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,photos: freezed == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,userRatingsTotal: freezed == userRatingsTotal ? _self.userRatingsTotal : userRatingsTotal // ignore: cast_nullable_to_non_nullable
as int?,drinkingInfo: freezed == drinkingInfo ? _self.drinkingInfo : drinkingInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,reviewAnalysis: freezed == reviewAnalysis ? _self.reviewAnalysis : reviewAnalysis // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Restaurant implements Restaurant {
  const _Restaurant({required this.name, required this.formattedAddress, required this.rating, required this.priceLevel, required this.placeId, this.menuHighlights, this.accessInfo, this.vicinity, final  Map<String, double>? location, this.businessStatus, final  List<String>? types, final  Map<String, dynamic>? openingHours, final  List<Map<String, dynamic>>? photos, this.userRatingsTotal, final  Map<String, dynamic>? drinkingInfo, final  Map<String, dynamic>? reviewAnalysis, this.website, this.phoneNumber}): _location = location,_types = types,_openingHours = openingHours,_photos = photos,_drinkingInfo = drinkingInfo,_reviewAnalysis = reviewAnalysis;
  factory _Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

@override final  String name;
@override final  String formattedAddress;
@override final  double rating;
@override final  int priceLevel;
@override final  String placeId;
@override final  String? menuHighlights;
@override final  String? accessInfo;
@override final  String? vicinity;
 final  Map<String, double>? _location;
@override Map<String, double>? get location {
  final value = _location;
  if (value == null) return null;
  if (_location is EqualUnmodifiableMapView) return _location;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? businessStatus;
 final  List<String>? _types;
@override List<String>? get types {
  final value = _types;
  if (value == null) return null;
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _openingHours;
@override Map<String, dynamic>? get openingHours {
  final value = _openingHours;
  if (value == null) return null;
  if (_openingHours is EqualUnmodifiableMapView) return _openingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>>? _photos;
@override List<Map<String, dynamic>>? get photos {
  final value = _photos;
  if (value == null) return null;
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? userRatingsTotal;
 final  Map<String, dynamic>? _drinkingInfo;
@override Map<String, dynamic>? get drinkingInfo {
  final value = _drinkingInfo;
  if (value == null) return null;
  if (_drinkingInfo is EqualUnmodifiableMapView) return _drinkingInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _reviewAnalysis;
@override Map<String, dynamic>? get reviewAnalysis {
  final value = _reviewAnalysis;
  if (value == null) return null;
  if (_reviewAnalysis is EqualUnmodifiableMapView) return _reviewAnalysis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? website;
@override final  String? phoneNumber;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantCopyWith<_Restaurant> get copyWith => __$RestaurantCopyWithImpl<_Restaurant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Restaurant&&(identical(other.name, name) || other.name == name)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.priceLevel, priceLevel) || other.priceLevel == priceLevel)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.menuHighlights, menuHighlights) || other.menuHighlights == menuHighlights)&&(identical(other.accessInfo, accessInfo) || other.accessInfo == accessInfo)&&(identical(other.vicinity, vicinity) || other.vicinity == vicinity)&&const DeepCollectionEquality().equals(other._location, _location)&&(identical(other.businessStatus, businessStatus) || other.businessStatus == businessStatus)&&const DeepCollectionEquality().equals(other._types, _types)&&const DeepCollectionEquality().equals(other._openingHours, _openingHours)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.userRatingsTotal, userRatingsTotal) || other.userRatingsTotal == userRatingsTotal)&&const DeepCollectionEquality().equals(other._drinkingInfo, _drinkingInfo)&&const DeepCollectionEquality().equals(other._reviewAnalysis, _reviewAnalysis)&&(identical(other.website, website) || other.website == website)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,formattedAddress,rating,priceLevel,placeId,menuHighlights,accessInfo,vicinity,const DeepCollectionEquality().hash(_location),businessStatus,const DeepCollectionEquality().hash(_types),const DeepCollectionEquality().hash(_openingHours),const DeepCollectionEquality().hash(_photos),userRatingsTotal,const DeepCollectionEquality().hash(_drinkingInfo),const DeepCollectionEquality().hash(_reviewAnalysis),website,phoneNumber);

@override
String toString() {
  return 'Restaurant(name: $name, formattedAddress: $formattedAddress, rating: $rating, priceLevel: $priceLevel, placeId: $placeId, menuHighlights: $menuHighlights, accessInfo: $accessInfo, vicinity: $vicinity, location: $location, businessStatus: $businessStatus, types: $types, openingHours: $openingHours, photos: $photos, userRatingsTotal: $userRatingsTotal, drinkingInfo: $drinkingInfo, reviewAnalysis: $reviewAnalysis, website: $website, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$RestaurantCopyWith<$Res> implements $RestaurantCopyWith<$Res> {
  factory _$RestaurantCopyWith(_Restaurant value, $Res Function(_Restaurant) _then) = __$RestaurantCopyWithImpl;
@override @useResult
$Res call({
 String name, String formattedAddress, double rating, int priceLevel, String placeId, String? menuHighlights, String? accessInfo, String? vicinity, Map<String, double>? location, String? businessStatus, List<String>? types, Map<String, dynamic>? openingHours, List<Map<String, dynamic>>? photos, int? userRatingsTotal, Map<String, dynamic>? drinkingInfo, Map<String, dynamic>? reviewAnalysis, String? website, String? phoneNumber
});




}
/// @nodoc
class __$RestaurantCopyWithImpl<$Res>
    implements _$RestaurantCopyWith<$Res> {
  __$RestaurantCopyWithImpl(this._self, this._then);

  final _Restaurant _self;
  final $Res Function(_Restaurant) _then;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? formattedAddress = null,Object? rating = null,Object? priceLevel = null,Object? placeId = null,Object? menuHighlights = freezed,Object? accessInfo = freezed,Object? vicinity = freezed,Object? location = freezed,Object? businessStatus = freezed,Object? types = freezed,Object? openingHours = freezed,Object? photos = freezed,Object? userRatingsTotal = freezed,Object? drinkingInfo = freezed,Object? reviewAnalysis = freezed,Object? website = freezed,Object? phoneNumber = freezed,}) {
  return _then(_Restaurant(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,formattedAddress: null == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,priceLevel: null == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as int,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,menuHighlights: freezed == menuHighlights ? _self.menuHighlights : menuHighlights // ignore: cast_nullable_to_non_nullable
as String?,accessInfo: freezed == accessInfo ? _self.accessInfo : accessInfo // ignore: cast_nullable_to_non_nullable
as String?,vicinity: freezed == vicinity ? _self.vicinity : vicinity // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self._location : location // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,businessStatus: freezed == businessStatus ? _self.businessStatus : businessStatus // ignore: cast_nullable_to_non_nullable
as String?,types: freezed == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>?,openingHours: freezed == openingHours ? _self._openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,photos: freezed == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,userRatingsTotal: freezed == userRatingsTotal ? _self.userRatingsTotal : userRatingsTotal // ignore: cast_nullable_to_non_nullable
as int?,drinkingInfo: freezed == drinkingInfo ? _self._drinkingInfo : drinkingInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,reviewAnalysis: freezed == reviewAnalysis ? _self._reviewAnalysis : reviewAnalysis // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
