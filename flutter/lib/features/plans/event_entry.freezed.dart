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

// dart format on
