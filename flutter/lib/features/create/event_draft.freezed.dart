// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventDraft {

 String get purpose; List<DateTime> get candidateDateTimes; String get allergiesEtc; int get budgetUpperLimit; List<String> get fixedQuestion; int get minutes;
/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDraftCopyWith<EventDraft> get copyWith => _$EventDraftCopyWithImpl<EventDraft>(this as EventDraft, _$identity);

  /// Serializes this EventDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDraft&&(identical(other.purpose, purpose) || other.purpose == purpose)&&const DeepCollectionEquality().equals(other.candidateDateTimes, candidateDateTimes)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&(identical(other.budgetUpperLimit, budgetUpperLimit) || other.budgetUpperLimit == budgetUpperLimit)&&const DeepCollectionEquality().equals(other.fixedQuestion, fixedQuestion)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purpose,const DeepCollectionEquality().hash(candidateDateTimes),allergiesEtc,budgetUpperLimit,const DeepCollectionEquality().hash(fixedQuestion),minutes);

@override
String toString() {
  return 'EventDraft(purpose: $purpose, candidateDateTimes: $candidateDateTimes, allergiesEtc: $allergiesEtc, budgetUpperLimit: $budgetUpperLimit, fixedQuestion: $fixedQuestion, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class $EventDraftCopyWith<$Res>  {
  factory $EventDraftCopyWith(EventDraft value, $Res Function(EventDraft) _then) = _$EventDraftCopyWithImpl;
@useResult
$Res call({
 String purpose, List<DateTime> candidateDateTimes, String allergiesEtc, int budgetUpperLimit, List<String> fixedQuestion, int minutes
});




}
/// @nodoc
class _$EventDraftCopyWithImpl<$Res>
    implements $EventDraftCopyWith<$Res> {
  _$EventDraftCopyWithImpl(this._self, this._then);

  final EventDraft _self;
  final $Res Function(EventDraft) _then;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? purpose = null,Object? candidateDateTimes = null,Object? allergiesEtc = null,Object? budgetUpperLimit = null,Object? fixedQuestion = null,Object? minutes = null,}) {
  return _then(_self.copyWith(
purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,candidateDateTimes: null == candidateDateTimes ? _self.candidateDateTimes : candidateDateTimes // ignore: cast_nullable_to_non_nullable
as List<DateTime>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,budgetUpperLimit: null == budgetUpperLimit ? _self.budgetUpperLimit : budgetUpperLimit // ignore: cast_nullable_to_non_nullable
as int,fixedQuestion: null == fixedQuestion ? _self.fixedQuestion : fixedQuestion // ignore: cast_nullable_to_non_nullable
as List<String>,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EventDraft implements EventDraft {
  const _EventDraft({required this.purpose, required final  List<DateTime> candidateDateTimes, required this.allergiesEtc, required this.budgetUpperLimit, required final  List<String> fixedQuestion, required this.minutes}): _candidateDateTimes = candidateDateTimes,_fixedQuestion = fixedQuestion;
  factory _EventDraft.fromJson(Map<String, dynamic> json) => _$EventDraftFromJson(json);

@override final  String purpose;
 final  List<DateTime> _candidateDateTimes;
@override List<DateTime> get candidateDateTimes {
  if (_candidateDateTimes is EqualUnmodifiableListView) return _candidateDateTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidateDateTimes);
}

@override final  String allergiesEtc;
@override final  int budgetUpperLimit;
 final  List<String> _fixedQuestion;
@override List<String> get fixedQuestion {
  if (_fixedQuestion is EqualUnmodifiableListView) return _fixedQuestion;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fixedQuestion);
}

@override final  int minutes;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDraftCopyWith<_EventDraft> get copyWith => __$EventDraftCopyWithImpl<_EventDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDraft&&(identical(other.purpose, purpose) || other.purpose == purpose)&&const DeepCollectionEquality().equals(other._candidateDateTimes, _candidateDateTimes)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&(identical(other.budgetUpperLimit, budgetUpperLimit) || other.budgetUpperLimit == budgetUpperLimit)&&const DeepCollectionEquality().equals(other._fixedQuestion, _fixedQuestion)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purpose,const DeepCollectionEquality().hash(_candidateDateTimes),allergiesEtc,budgetUpperLimit,const DeepCollectionEquality().hash(_fixedQuestion),minutes);

@override
String toString() {
  return 'EventDraft(purpose: $purpose, candidateDateTimes: $candidateDateTimes, allergiesEtc: $allergiesEtc, budgetUpperLimit: $budgetUpperLimit, fixedQuestion: $fixedQuestion, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class _$EventDraftCopyWith<$Res> implements $EventDraftCopyWith<$Res> {
  factory _$EventDraftCopyWith(_EventDraft value, $Res Function(_EventDraft) _then) = __$EventDraftCopyWithImpl;
@override @useResult
$Res call({
 String purpose, List<DateTime> candidateDateTimes, String allergiesEtc, int budgetUpperLimit, List<String> fixedQuestion, int minutes
});




}
/// @nodoc
class __$EventDraftCopyWithImpl<$Res>
    implements _$EventDraftCopyWith<$Res> {
  __$EventDraftCopyWithImpl(this._self, this._then);

  final _EventDraft _self;
  final $Res Function(_EventDraft) _then;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? purpose = null,Object? candidateDateTimes = null,Object? allergiesEtc = null,Object? budgetUpperLimit = null,Object? fixedQuestion = null,Object? minutes = null,}) {
  return _then(_EventDraft(
purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,candidateDateTimes: null == candidateDateTimes ? _self._candidateDateTimes : candidateDateTimes // ignore: cast_nullable_to_non_nullable
as List<DateTime>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,budgetUpperLimit: null == budgetUpperLimit ? _self.budgetUpperLimit : budgetUpperLimit // ignore: cast_nullable_to_non_nullable
as int,fixedQuestion: null == fixedQuestion ? _self._fixedQuestion : fixedQuestion // ignore: cast_nullable_to_non_nullable
as List<String>,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
