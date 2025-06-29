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

 String? get id; String get eventName;@DateTimeToTimestampConverter() DateTime get dueDate; List<(DateTime start, DateTime end)> get candidateDateTimes; List<String> get candidateAreas; String get allergiesEtc; List<String> get organizerId; List<String> get participantId;
/// Create a copy of EventEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventEntryCopyWith<EventEntry> get copyWith => _$EventEntryCopyWithImpl<EventEntry>(this as EventEntry, _$identity);

  /// Serializes this EventEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&const DeepCollectionEquality().equals(other.candidateDateTimes, candidateDateTimes)&&const DeepCollectionEquality().equals(other.candidateAreas, candidateAreas)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&const DeepCollectionEquality().equals(other.organizerId, organizerId)&&const DeepCollectionEquality().equals(other.participantId, participantId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventName,dueDate,const DeepCollectionEquality().hash(candidateDateTimes),const DeepCollectionEquality().hash(candidateAreas),allergiesEtc,const DeepCollectionEquality().hash(organizerId),const DeepCollectionEquality().hash(participantId));

@override
String toString() {
  return 'EventEntry(id: $id, eventName: $eventName, dueDate: $dueDate, candidateDateTimes: $candidateDateTimes, candidateAreas: $candidateAreas, allergiesEtc: $allergiesEtc, organizerId: $organizerId, participantId: $participantId)';
}


}

/// @nodoc
abstract mixin class $EventEntryCopyWith<$Res>  {
  factory $EventEntryCopyWith(EventEntry value, $Res Function(EventEntry) _then) = _$EventEntryCopyWithImpl;
@useResult
$Res call({
 String? id, String eventName,@DateTimeToTimestampConverter() DateTime dueDate, List<(DateTime start, DateTime end)> candidateDateTimes, List<String> candidateAreas, String allergiesEtc, List<String> organizerId, List<String> participantId
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? eventName = null,Object? dueDate = null,Object? candidateDateTimes = null,Object? candidateAreas = null,Object? allergiesEtc = null,Object? organizerId = null,Object? participantId = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventName: null == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,candidateDateTimes: null == candidateDateTimes ? _self.candidateDateTimes : candidateDateTimes // ignore: cast_nullable_to_non_nullable
as List<(DateTime start, DateTime end)>,candidateAreas: null == candidateAreas ? _self.candidateAreas : candidateAreas // ignore: cast_nullable_to_non_nullable
as List<String>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as List<String>,participantId: null == participantId ? _self.participantId : participantId // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EventEntry implements EventEntry {
  const _EventEntry({this.id, required this.eventName, @DateTimeToTimestampConverter() required this.dueDate, required final  List<(DateTime start, DateTime end)> candidateDateTimes, required final  List<String> candidateAreas, required this.allergiesEtc, required final  List<String> organizerId, required final  List<String> participantId}): _candidateDateTimes = candidateDateTimes,_candidateAreas = candidateAreas,_organizerId = organizerId,_participantId = participantId;
  factory _EventEntry.fromJson(Map<String, dynamic> json) => _$EventEntryFromJson(json);

@override final  String? id;
@override final  String eventName;
@override@DateTimeToTimestampConverter() final  DateTime dueDate;
 final  List<(DateTime start, DateTime end)> _candidateDateTimes;
@override List<(DateTime start, DateTime end)> get candidateDateTimes {
  if (_candidateDateTimes is EqualUnmodifiableListView) return _candidateDateTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidateDateTimes);
}

 final  List<String> _candidateAreas;
@override List<String> get candidateAreas {
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&const DeepCollectionEquality().equals(other._candidateDateTimes, _candidateDateTimes)&&const DeepCollectionEquality().equals(other._candidateAreas, _candidateAreas)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&const DeepCollectionEquality().equals(other._organizerId, _organizerId)&&const DeepCollectionEquality().equals(other._participantId, _participantId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventName,dueDate,const DeepCollectionEquality().hash(_candidateDateTimes),const DeepCollectionEquality().hash(_candidateAreas),allergiesEtc,const DeepCollectionEquality().hash(_organizerId),const DeepCollectionEquality().hash(_participantId));

@override
String toString() {
  return 'EventEntry(id: $id, eventName: $eventName, dueDate: $dueDate, candidateDateTimes: $candidateDateTimes, candidateAreas: $candidateAreas, allergiesEtc: $allergiesEtc, organizerId: $organizerId, participantId: $participantId)';
}


}

/// @nodoc
abstract mixin class _$EventEntryCopyWith<$Res> implements $EventEntryCopyWith<$Res> {
  factory _$EventEntryCopyWith(_EventEntry value, $Res Function(_EventEntry) _then) = __$EventEntryCopyWithImpl;
@override @useResult
$Res call({
 String? id, String eventName,@DateTimeToTimestampConverter() DateTime dueDate, List<(DateTime start, DateTime end)> candidateDateTimes, List<String> candidateAreas, String allergiesEtc, List<String> organizerId, List<String> participantId
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? eventName = null,Object? dueDate = null,Object? candidateDateTimes = null,Object? candidateAreas = null,Object? allergiesEtc = null,Object? organizerId = null,Object? participantId = null,}) {
  return _then(_EventEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventName: null == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,candidateDateTimes: null == candidateDateTimes ? _self._candidateDateTimes : candidateDateTimes // ignore: cast_nullable_to_non_nullable
as List<(DateTime start, DateTime end)>,candidateAreas: null == candidateAreas ? _self._candidateAreas : candidateAreas // ignore: cast_nullable_to_non_nullable
as List<String>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self._organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as List<String>,participantId: null == participantId ? _self._participantId : participantId // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$CandidateDateTime {

 String? get id; String? get eventId;@DateTimeToTimestampConverter() DateTime get start;@DateTimeToTimestampConverter() DateTime get end;
/// Create a copy of CandidateDateTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateDateTimeCopyWith<CandidateDateTime> get copyWith => _$CandidateDateTimeCopyWithImpl<CandidateDateTime>(this as CandidateDateTime, _$identity);

  /// Serializes this CandidateDateTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateDateTime&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,start,end);

@override
String toString() {
  return 'CandidateDateTime(id: $id, eventId: $eventId, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $CandidateDateTimeCopyWith<$Res>  {
  factory $CandidateDateTimeCopyWith(CandidateDateTime value, $Res Function(CandidateDateTime) _then) = _$CandidateDateTimeCopyWithImpl;
@useResult
$Res call({
 String? id, String? eventId,@DateTimeToTimestampConverter() DateTime start,@DateTimeToTimestampConverter() DateTime end
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? eventId = freezed,Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CandidateDateTime implements CandidateDateTime {
  const _CandidateDateTime({this.id, this.eventId, @DateTimeToTimestampConverter() required this.start, @DateTimeToTimestampConverter() required this.end});
  factory _CandidateDateTime.fromJson(Map<String, dynamic> json) => _$CandidateDateTimeFromJson(json);

@override final  String? id;
@override final  String? eventId;
@override@DateTimeToTimestampConverter() final  DateTime start;
@override@DateTimeToTimestampConverter() final  DateTime end;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateDateTime&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,start,end);

@override
String toString() {
  return 'CandidateDateTime(id: $id, eventId: $eventId, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$CandidateDateTimeCopyWith<$Res> implements $CandidateDateTimeCopyWith<$Res> {
  factory _$CandidateDateTimeCopyWith(_CandidateDateTime value, $Res Function(_CandidateDateTime) _then) = __$CandidateDateTimeCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? eventId,@DateTimeToTimestampConverter() DateTime start,@DateTimeToTimestampConverter() DateTime end
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? eventId = freezed,Object? start = null,Object? end = null,}) {
  return _then(_CandidateDateTime(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CandidateArea {

 String? get id; String? get eventId;@GeoPointToJsonConverter() GeoPoint get location;/// 半径 m
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateArea&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.location, location) || other.location == location)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,location,radius);

@override
String toString() {
  return 'CandidateArea(id: $id, eventId: $eventId, location: $location, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $CandidateAreaCopyWith<$Res>  {
  factory $CandidateAreaCopyWith(CandidateArea value, $Res Function(CandidateArea) _then) = _$CandidateAreaCopyWithImpl;
@useResult
$Res call({
 String? id, String? eventId,@GeoPointToJsonConverter() GeoPoint location, int radius
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? eventId = freezed,Object? location = null,Object? radius = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CandidateArea implements CandidateArea {
  const _CandidateArea({this.id, this.eventId, @GeoPointToJsonConverter() required this.location, required this.radius});
  factory _CandidateArea.fromJson(Map<String, dynamic> json) => _$CandidateAreaFromJson(json);

@override final  String? id;
@override final  String? eventId;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateArea&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.location, location) || other.location == location)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,location,radius);

@override
String toString() {
  return 'CandidateArea(id: $id, eventId: $eventId, location: $location, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$CandidateAreaCopyWith<$Res> implements $CandidateAreaCopyWith<$Res> {
  factory _$CandidateAreaCopyWith(_CandidateArea value, $Res Function(_CandidateArea) _then) = __$CandidateAreaCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? eventId,@GeoPointToJsonConverter() GeoPoint location, int radius
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? eventId = freezed,Object? location = null,Object? radius = null,}) {
  return _then(_CandidateArea(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EventResult {

 String? get id; String? get eventId;@DateTimeToTimestampConverter() DateTime get optimalDate;@DateTimeToTimestampConverter() DateTime get optimalEnd;
/// Create a copy of EventResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventResultCopyWith<EventResult> get copyWith => _$EventResultCopyWithImpl<EventResult>(this as EventResult, _$identity);

  /// Serializes this EventResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventResult&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.optimalDate, optimalDate) || other.optimalDate == optimalDate)&&(identical(other.optimalEnd, optimalEnd) || other.optimalEnd == optimalEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,optimalDate,optimalEnd);

@override
String toString() {
  return 'EventResult(id: $id, eventId: $eventId, optimalDate: $optimalDate, optimalEnd: $optimalEnd)';
}


}

/// @nodoc
abstract mixin class $EventResultCopyWith<$Res>  {
  factory $EventResultCopyWith(EventResult value, $Res Function(EventResult) _then) = _$EventResultCopyWithImpl;
@useResult
$Res call({
 String? id, String? eventId,@DateTimeToTimestampConverter() DateTime optimalDate,@DateTimeToTimestampConverter() DateTime optimalEnd
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? eventId = freezed,Object? optimalDate = null,Object? optimalEnd = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,optimalDate: null == optimalDate ? _self.optimalDate : optimalDate // ignore: cast_nullable_to_non_nullable
as DateTime,optimalEnd: null == optimalEnd ? _self.optimalEnd : optimalEnd // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EventResult implements EventResult {
  const _EventResult({this.id, this.eventId, @DateTimeToTimestampConverter() required this.optimalDate, @DateTimeToTimestampConverter() required this.optimalEnd});
  factory _EventResult.fromJson(Map<String, dynamic> json) => _$EventResultFromJson(json);

@override final  String? id;
@override final  String? eventId;
@override@DateTimeToTimestampConverter() final  DateTime optimalDate;
@override@DateTimeToTimestampConverter() final  DateTime optimalEnd;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventResult&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.optimalDate, optimalDate) || other.optimalDate == optimalDate)&&(identical(other.optimalEnd, optimalEnd) || other.optimalEnd == optimalEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,optimalDate,optimalEnd);

@override
String toString() {
  return 'EventResult(id: $id, eventId: $eventId, optimalDate: $optimalDate, optimalEnd: $optimalEnd)';
}


}

/// @nodoc
abstract mixin class _$EventResultCopyWith<$Res> implements $EventResultCopyWith<$Res> {
  factory _$EventResultCopyWith(_EventResult value, $Res Function(_EventResult) _then) = __$EventResultCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? eventId,@DateTimeToTimestampConverter() DateTime optimalDate,@DateTimeToTimestampConverter() DateTime optimalEnd
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? eventId = freezed,Object? optimalDate = null,Object? optimalEnd = null,}) {
  return _then(_EventResult(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,optimalDate: null == optimalDate ? _self.optimalDate : optimalDate // ignore: cast_nullable_to_non_nullable
as DateTime,optimalEnd: null == optimalEnd ? _self.optimalEnd : optimalEnd // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$OptimalRestaurant {

 String? get id; String? get eventId; String? get resultId; String get name; String get formattedAddress; int get rating; int get priceLevel; String get menuHighlights; String get accessInfo; String get placeId;
/// Create a copy of OptimalRestaurant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OptimalRestaurantCopyWith<OptimalRestaurant> get copyWith => _$OptimalRestaurantCopyWithImpl<OptimalRestaurant>(this as OptimalRestaurant, _$identity);

  /// Serializes this OptimalRestaurant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OptimalRestaurant&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.resultId, resultId) || other.resultId == resultId)&&(identical(other.name, name) || other.name == name)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.priceLevel, priceLevel) || other.priceLevel == priceLevel)&&(identical(other.menuHighlights, menuHighlights) || other.menuHighlights == menuHighlights)&&(identical(other.accessInfo, accessInfo) || other.accessInfo == accessInfo)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,resultId,name,formattedAddress,rating,priceLevel,menuHighlights,accessInfo,placeId);

@override
String toString() {
  return 'OptimalRestaurant(id: $id, eventId: $eventId, resultId: $resultId, name: $name, formattedAddress: $formattedAddress, rating: $rating, priceLevel: $priceLevel, menuHighlights: $menuHighlights, accessInfo: $accessInfo, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class $OptimalRestaurantCopyWith<$Res>  {
  factory $OptimalRestaurantCopyWith(OptimalRestaurant value, $Res Function(OptimalRestaurant) _then) = _$OptimalRestaurantCopyWithImpl;
@useResult
$Res call({
 String? id, String? eventId, String? resultId, String name, String formattedAddress, int rating, int priceLevel, String menuHighlights, String accessInfo, String placeId
});




}
/// @nodoc
class _$OptimalRestaurantCopyWithImpl<$Res>
    implements $OptimalRestaurantCopyWith<$Res> {
  _$OptimalRestaurantCopyWithImpl(this._self, this._then);

  final OptimalRestaurant _self;
  final $Res Function(OptimalRestaurant) _then;

/// Create a copy of OptimalRestaurant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? eventId = freezed,Object? resultId = freezed,Object? name = null,Object? formattedAddress = null,Object? rating = null,Object? priceLevel = null,Object? menuHighlights = null,Object? accessInfo = null,Object? placeId = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,resultId: freezed == resultId ? _self.resultId : resultId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,formattedAddress: null == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,priceLevel: null == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as int,menuHighlights: null == menuHighlights ? _self.menuHighlights : menuHighlights // ignore: cast_nullable_to_non_nullable
as String,accessInfo: null == accessInfo ? _self.accessInfo : accessInfo // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _OptimalRestaurant implements OptimalRestaurant {
  const _OptimalRestaurant({this.id, this.eventId, this.resultId, required this.name, required this.formattedAddress, required this.rating, required this.priceLevel, required this.menuHighlights, required this.accessInfo, required this.placeId});
  factory _OptimalRestaurant.fromJson(Map<String, dynamic> json) => _$OptimalRestaurantFromJson(json);

@override final  String? id;
@override final  String? eventId;
@override final  String? resultId;
@override final  String name;
@override final  String formattedAddress;
@override final  int rating;
@override final  int priceLevel;
@override final  String menuHighlights;
@override final  String accessInfo;
@override final  String placeId;

/// Create a copy of OptimalRestaurant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OptimalRestaurantCopyWith<_OptimalRestaurant> get copyWith => __$OptimalRestaurantCopyWithImpl<_OptimalRestaurant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OptimalRestaurantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OptimalRestaurant&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.resultId, resultId) || other.resultId == resultId)&&(identical(other.name, name) || other.name == name)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.priceLevel, priceLevel) || other.priceLevel == priceLevel)&&(identical(other.menuHighlights, menuHighlights) || other.menuHighlights == menuHighlights)&&(identical(other.accessInfo, accessInfo) || other.accessInfo == accessInfo)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,resultId,name,formattedAddress,rating,priceLevel,menuHighlights,accessInfo,placeId);

@override
String toString() {
  return 'OptimalRestaurant(id: $id, eventId: $eventId, resultId: $resultId, name: $name, formattedAddress: $formattedAddress, rating: $rating, priceLevel: $priceLevel, menuHighlights: $menuHighlights, accessInfo: $accessInfo, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class _$OptimalRestaurantCopyWith<$Res> implements $OptimalRestaurantCopyWith<$Res> {
  factory _$OptimalRestaurantCopyWith(_OptimalRestaurant value, $Res Function(_OptimalRestaurant) _then) = __$OptimalRestaurantCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? eventId, String? resultId, String name, String formattedAddress, int rating, int priceLevel, String menuHighlights, String accessInfo, String placeId
});




}
/// @nodoc
class __$OptimalRestaurantCopyWithImpl<$Res>
    implements _$OptimalRestaurantCopyWith<$Res> {
  __$OptimalRestaurantCopyWithImpl(this._self, this._then);

  final _OptimalRestaurant _self;
  final $Res Function(_OptimalRestaurant) _then;

/// Create a copy of OptimalRestaurant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? eventId = freezed,Object? resultId = freezed,Object? name = null,Object? formattedAddress = null,Object? rating = null,Object? priceLevel = null,Object? menuHighlights = null,Object? accessInfo = null,Object? placeId = null,}) {
  return _then(_OptimalRestaurant(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,resultId: freezed == resultId ? _self.resultId : resultId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,formattedAddress: null == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,priceLevel: null == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as int,menuHighlights: null == menuHighlights ? _self.menuHighlights : menuHighlights // ignore: cast_nullable_to_non_nullable
as String,accessInfo: null == accessInfo ? _self.accessInfo : accessInfo // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
