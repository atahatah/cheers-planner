// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventEntry {

 String? get id; String? get aiRecArea; String? get aiRecDate; String? get aiRecStore; String get purpose;@DateTimeToTimestampConverter() DateTime get dueDate;@ListToMapConverter<CandidateDateTime>(prefix: 'datetime') List<CandidateDateTime> get candidateDateTimes;@ListToMapConverter<CandidateArea>(prefix: 'area') List<CandidateArea> get candidateAreas; String get allergiesEtc; List<String> get organizerId; List<String> get participantId; int get budgetUpperLimit; List<String> get fixedQuestion; int get minutes;
/// Create a copy of EventEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventEntryCopyWith<EventEntry> get copyWith => _$EventEntryCopyWithImpl<EventEntry>(this as EventEntry, _$identity);

  /// Serializes this EventEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.aiRecArea, aiRecArea) || other.aiRecArea == aiRecArea)&&(identical(other.aiRecDate, aiRecDate) || other.aiRecDate == aiRecDate)&&(identical(other.aiRecStore, aiRecStore) || other.aiRecStore == aiRecStore)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&const DeepCollectionEquality().equals(other.candidateDateTimes, candidateDateTimes)&&const DeepCollectionEquality().equals(other.candidateAreas, candidateAreas)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&const DeepCollectionEquality().equals(other.organizerId, organizerId)&&const DeepCollectionEquality().equals(other.participantId, participantId)&&(identical(other.budgetUpperLimit, budgetUpperLimit) || other.budgetUpperLimit == budgetUpperLimit)&&const DeepCollectionEquality().equals(other.fixedQuestion, fixedQuestion)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,aiRecArea,aiRecDate,aiRecStore,purpose,dueDate,const DeepCollectionEquality().hash(candidateDateTimes),const DeepCollectionEquality().hash(candidateAreas),allergiesEtc,const DeepCollectionEquality().hash(organizerId),const DeepCollectionEquality().hash(participantId),budgetUpperLimit,const DeepCollectionEquality().hash(fixedQuestion),minutes);

@override
String toString() {
  return 'EventEntry(id: $id, aiRecArea: $aiRecArea, aiRecDate: $aiRecDate, aiRecStore: $aiRecStore, purpose: $purpose, dueDate: $dueDate, candidateDateTimes: $candidateDateTimes, candidateAreas: $candidateAreas, allergiesEtc: $allergiesEtc, organizerId: $organizerId, participantId: $participantId, budgetUpperLimit: $budgetUpperLimit, fixedQuestion: $fixedQuestion, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class $EventEntryCopyWith<$Res>  {
  factory $EventEntryCopyWith(EventEntry value, $Res Function(EventEntry) _then) = _$EventEntryCopyWithImpl;
@useResult
$Res call({
 String? id, String? aiRecArea, String? aiRecDate, String? aiRecStore, String purpose,@DateTimeToTimestampConverter() DateTime dueDate,@ListToMapConverter<CandidateDateTime>(prefix: 'datetime') List<CandidateDateTime> candidateDateTimes,@ListToMapConverter<CandidateArea>(prefix: 'area') List<CandidateArea> candidateAreas, String allergiesEtc, List<String> organizerId, List<String> participantId, int budgetUpperLimit, List<String> fixedQuestion, int minutes
});




}
/// @nodoc
class _$EventEntryCopyWithImpl<$Res>
    implements $EventEntryCopyWith<$Res> {
  _$EventEntryCopyWithImpl(this._self, this._then);

  final EventEntry _self;
  final $Res Function(EventEntry) _then;

/// Create a copy of EventEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? aiRecArea = freezed,Object? aiRecDate = freezed,Object? aiRecStore = freezed,Object? purpose = null,Object? dueDate = null,Object? candidateDateTimes = null,Object? candidateAreas = null,Object? allergiesEtc = null,Object? organizerId = null,Object? participantId = null,Object? budgetUpperLimit = null,Object? fixedQuestion = null,Object? minutes = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,aiRecArea: freezed == aiRecArea ? _self.aiRecArea : aiRecArea // ignore: cast_nullable_to_non_nullable
as String?,aiRecDate: freezed == aiRecDate ? _self.aiRecDate : aiRecDate // ignore: cast_nullable_to_non_nullable
as String?,aiRecStore: freezed == aiRecStore ? _self.aiRecStore : aiRecStore // ignore: cast_nullable_to_non_nullable
as String?,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,candidateDateTimes: null == candidateDateTimes ? _self.candidateDateTimes : candidateDateTimes // ignore: cast_nullable_to_non_nullable
as List<CandidateDateTime>,candidateAreas: null == candidateAreas ? _self.candidateAreas : candidateAreas // ignore: cast_nullable_to_non_nullable
as List<CandidateArea>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as List<String>,participantId: null == participantId ? _self.participantId : participantId // ignore: cast_nullable_to_non_nullable
as List<String>,budgetUpperLimit: null == budgetUpperLimit ? _self.budgetUpperLimit : budgetUpperLimit // ignore: cast_nullable_to_non_nullable
as int,fixedQuestion: null == fixedQuestion ? _self.fixedQuestion : fixedQuestion // ignore: cast_nullable_to_non_nullable
as List<String>,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EventEntry implements EventEntry {
  const _EventEntry({this.id, this.aiRecArea, this.aiRecDate, this.aiRecStore, required this.purpose, @DateTimeToTimestampConverter() required this.dueDate, @ListToMapConverter<CandidateDateTime>(prefix: 'datetime') required final  List<CandidateDateTime> candidateDateTimes, @ListToMapConverter<CandidateArea>(prefix: 'area') required final  List<CandidateArea> candidateAreas, required this.allergiesEtc, required final  List<String> organizerId, required final  List<String> participantId, required this.budgetUpperLimit, required final  List<String> fixedQuestion, required this.minutes}): _candidateDateTimes = candidateDateTimes,_candidateAreas = candidateAreas,_organizerId = organizerId,_participantId = participantId,_fixedQuestion = fixedQuestion;
  factory _EventEntry.fromJson(Map<String, dynamic> json) => _$EventEntryFromJson(json);

@override final  String? id;
@override final  String? aiRecArea;
@override final  String? aiRecDate;
@override final  String? aiRecStore;
@override final  String purpose;
@override@DateTimeToTimestampConverter() final  DateTime dueDate;
 final  List<CandidateDateTime> _candidateDateTimes;
@override@ListToMapConverter<CandidateDateTime>(prefix: 'datetime') List<CandidateDateTime> get candidateDateTimes {
  if (_candidateDateTimes is EqualUnmodifiableListView) return _candidateDateTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidateDateTimes);
}

 final  List<CandidateArea> _candidateAreas;
@override@ListToMapConverter<CandidateArea>(prefix: 'area') List<CandidateArea> get candidateAreas {
  if (_candidateAreas is EqualUnmodifiableListView) return _candidateAreas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidateAreas);
}

@override final  String allergiesEtc;
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

@override final  int budgetUpperLimit;
 final  List<String> _fixedQuestion;
@override List<String> get fixedQuestion {
  if (_fixedQuestion is EqualUnmodifiableListView) return _fixedQuestion;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fixedQuestion);
}

@override final  int minutes;

/// Create a copy of EventEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventEntryCopyWith<_EventEntry> get copyWith => __$EventEntryCopyWithImpl<_EventEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.aiRecArea, aiRecArea) || other.aiRecArea == aiRecArea)&&(identical(other.aiRecDate, aiRecDate) || other.aiRecDate == aiRecDate)&&(identical(other.aiRecStore, aiRecStore) || other.aiRecStore == aiRecStore)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&const DeepCollectionEquality().equals(other._candidateDateTimes, _candidateDateTimes)&&const DeepCollectionEquality().equals(other._candidateAreas, _candidateAreas)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&const DeepCollectionEquality().equals(other._organizerId, _organizerId)&&const DeepCollectionEquality().equals(other._participantId, _participantId)&&(identical(other.budgetUpperLimit, budgetUpperLimit) || other.budgetUpperLimit == budgetUpperLimit)&&const DeepCollectionEquality().equals(other._fixedQuestion, _fixedQuestion)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,aiRecArea,aiRecDate,aiRecStore,purpose,dueDate,const DeepCollectionEquality().hash(_candidateDateTimes),const DeepCollectionEquality().hash(_candidateAreas),allergiesEtc,const DeepCollectionEquality().hash(_organizerId),const DeepCollectionEquality().hash(_participantId),budgetUpperLimit,const DeepCollectionEquality().hash(_fixedQuestion),minutes);

@override
String toString() {
  return 'EventEntry(id: $id, aiRecArea: $aiRecArea, aiRecDate: $aiRecDate, aiRecStore: $aiRecStore, purpose: $purpose, dueDate: $dueDate, candidateDateTimes: $candidateDateTimes, candidateAreas: $candidateAreas, allergiesEtc: $allergiesEtc, organizerId: $organizerId, participantId: $participantId, budgetUpperLimit: $budgetUpperLimit, fixedQuestion: $fixedQuestion, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class _$EventEntryCopyWith<$Res> implements $EventEntryCopyWith<$Res> {
  factory _$EventEntryCopyWith(_EventEntry value, $Res Function(_EventEntry) _then) = __$EventEntryCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? aiRecArea, String? aiRecDate, String? aiRecStore, String purpose,@DateTimeToTimestampConverter() DateTime dueDate,@ListToMapConverter<CandidateDateTime>(prefix: 'datetime') List<CandidateDateTime> candidateDateTimes,@ListToMapConverter<CandidateArea>(prefix: 'area') List<CandidateArea> candidateAreas, String allergiesEtc, List<String> organizerId, List<String> participantId, int budgetUpperLimit, List<String> fixedQuestion, int minutes
});




}
/// @nodoc
class __$EventEntryCopyWithImpl<$Res>
    implements _$EventEntryCopyWith<$Res> {
  __$EventEntryCopyWithImpl(this._self, this._then);

  final _EventEntry _self;
  final $Res Function(_EventEntry) _then;

/// Create a copy of EventEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? aiRecArea = freezed,Object? aiRecDate = freezed,Object? aiRecStore = freezed,Object? purpose = null,Object? dueDate = null,Object? candidateDateTimes = null,Object? candidateAreas = null,Object? allergiesEtc = null,Object? organizerId = null,Object? participantId = null,Object? budgetUpperLimit = null,Object? fixedQuestion = null,Object? minutes = null,}) {
  return _then(_EventEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,aiRecArea: freezed == aiRecArea ? _self.aiRecArea : aiRecArea // ignore: cast_nullable_to_non_nullable
as String?,aiRecDate: freezed == aiRecDate ? _self.aiRecDate : aiRecDate // ignore: cast_nullable_to_non_nullable
as String?,aiRecStore: freezed == aiRecStore ? _self.aiRecStore : aiRecStore // ignore: cast_nullable_to_non_nullable
as String?,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,candidateDateTimes: null == candidateDateTimes ? _self._candidateDateTimes : candidateDateTimes // ignore: cast_nullable_to_non_nullable
as List<CandidateDateTime>,candidateAreas: null == candidateAreas ? _self._candidateAreas : candidateAreas // ignore: cast_nullable_to_non_nullable
as List<CandidateArea>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self._organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as List<String>,participantId: null == participantId ? _self._participantId : participantId // ignore: cast_nullable_to_non_nullable
as List<String>,budgetUpperLimit: null == budgetUpperLimit ? _self.budgetUpperLimit : budgetUpperLimit // ignore: cast_nullable_to_non_nullable
as int,fixedQuestion: null == fixedQuestion ? _self._fixedQuestion : fixedQuestion // ignore: cast_nullable_to_non_nullable
as List<String>,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,
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

@GeoPointToJsonConverter() GeoPoint get location;/// 半径 m
 int get radius;
/// Create a copy of CandidateArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateAreaCopyWith<CandidateArea> get copyWith => _$CandidateAreaCopyWithImpl<CandidateArea>(this as CandidateArea, _$identity);

  /// Serializes this CandidateArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateArea&&(identical(other.location, location) || other.location == location)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,radius);

@override
String toString() {
  return 'CandidateArea(location: $location, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $CandidateAreaCopyWith<$Res>  {
  factory $CandidateAreaCopyWith(CandidateArea value, $Res Function(CandidateArea) _then) = _$CandidateAreaCopyWithImpl;
@useResult
$Res call({
@GeoPointToJsonConverter() GeoPoint location, int radius
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
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? radius = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CandidateArea implements CandidateArea {
  const _CandidateArea({@GeoPointToJsonConverter() required this.location, required this.radius});
  factory _CandidateArea.fromJson(Map<String, dynamic> json) => _$CandidateAreaFromJson(json);

@override@GeoPointToJsonConverter() final  GeoPoint location;
/// 半径 m
@override final  int radius;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateArea&&(identical(other.location, location) || other.location == location)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,radius);

@override
String toString() {
  return 'CandidateArea(location: $location, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$CandidateAreaCopyWith<$Res> implements $CandidateAreaCopyWith<$Res> {
  factory _$CandidateAreaCopyWith(_CandidateArea value, $Res Function(_CandidateArea) _then) = __$CandidateAreaCopyWithImpl;
@override @useResult
$Res call({
@GeoPointToJsonConverter() GeoPoint location, int radius
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
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? radius = null,}) {
  return _then(_CandidateArea(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
