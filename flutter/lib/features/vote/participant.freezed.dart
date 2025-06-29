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

 String? get id; String? get eventId; String get name; String get phoneNumber; String? get positionOrGrade; int get desiredBudget;@DateTimeListToTimestampListConverter() List<DateTime> get desiredDates; List<String> get desiredLocations;@ListToMapConverter<QuestionAnswer>(prefix: 'custom-') List<QuestionAnswer> get customQuestions;@ListToMapConverter<QuestionAnswer>(prefix: 'question-') List<QuestionAnswer> get questions; String get allergiesEtc;@CreatedAtField() DateTime? get submittedAt;@UpdatedAtField() DateTime? get updatedAt;
/// Create a copy of EventParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventParticipantCopyWith<EventParticipant> get copyWith => _$EventParticipantCopyWithImpl<EventParticipant>(this as EventParticipant, _$identity);

  /// Serializes this EventParticipant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventParticipant&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.positionOrGrade, positionOrGrade) || other.positionOrGrade == positionOrGrade)&&(identical(other.desiredBudget, desiredBudget) || other.desiredBudget == desiredBudget)&&const DeepCollectionEquality().equals(other.desiredDates, desiredDates)&&const DeepCollectionEquality().equals(other.desiredLocations, desiredLocations)&&const DeepCollectionEquality().equals(other.customQuestions, customQuestions)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,name,phoneNumber,positionOrGrade,desiredBudget,const DeepCollectionEquality().hash(desiredDates),const DeepCollectionEquality().hash(desiredLocations),const DeepCollectionEquality().hash(customQuestions),const DeepCollectionEquality().hash(questions),allergiesEtc,submittedAt,updatedAt);

@override
String toString() {
  return 'EventParticipant(id: $id, eventId: $eventId, name: $name, phoneNumber: $phoneNumber, positionOrGrade: $positionOrGrade, desiredBudget: $desiredBudget, desiredDates: $desiredDates, desiredLocations: $desiredLocations, customQuestions: $customQuestions, questions: $questions, allergiesEtc: $allergiesEtc, submittedAt: $submittedAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EventParticipantCopyWith<$Res>  {
  factory $EventParticipantCopyWith(EventParticipant value, $Res Function(EventParticipant) _then) = _$EventParticipantCopyWithImpl;
@useResult
$Res call({
 String? id, String? eventId, String name, String phoneNumber, String? positionOrGrade, int desiredBudget,@DateTimeListToTimestampListConverter() List<DateTime> desiredDates, List<String> desiredLocations,@ListToMapConverter<QuestionAnswer>(prefix: 'custom-') List<QuestionAnswer> customQuestions,@ListToMapConverter<QuestionAnswer>(prefix: 'question-') List<QuestionAnswer> questions, String allergiesEtc,@CreatedAtField() DateTime? submittedAt,@UpdatedAtField() DateTime? updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? eventId = freezed,Object? name = null,Object? phoneNumber = null,Object? positionOrGrade = freezed,Object? desiredBudget = null,Object? desiredDates = null,Object? desiredLocations = null,Object? customQuestions = null,Object? questions = null,Object? allergiesEtc = null,Object? submittedAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,positionOrGrade: freezed == positionOrGrade ? _self.positionOrGrade : positionOrGrade // ignore: cast_nullable_to_non_nullable
as String?,desiredBudget: null == desiredBudget ? _self.desiredBudget : desiredBudget // ignore: cast_nullable_to_non_nullable
as int,desiredDates: null == desiredDates ? _self.desiredDates : desiredDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,desiredLocations: null == desiredLocations ? _self.desiredLocations : desiredLocations // ignore: cast_nullable_to_non_nullable
as List<String>,customQuestions: null == customQuestions ? _self.customQuestions : customQuestions // ignore: cast_nullable_to_non_nullable
as List<QuestionAnswer>,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuestionAnswer>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EventParticipant implements EventParticipant {
  const _EventParticipant({this.id, this.eventId, required this.name, required this.phoneNumber, required this.positionOrGrade, required this.desiredBudget, @DateTimeListToTimestampListConverter() required final  List<DateTime> desiredDates, required final  List<String> desiredLocations, @ListToMapConverter<QuestionAnswer>(prefix: 'custom-') required final  List<QuestionAnswer> customQuestions, @ListToMapConverter<QuestionAnswer>(prefix: 'question-') required final  List<QuestionAnswer> questions, required this.allergiesEtc, @CreatedAtField() this.submittedAt, @UpdatedAtField() this.updatedAt}): _desiredDates = desiredDates,_desiredLocations = desiredLocations,_customQuestions = customQuestions,_questions = questions;
  factory _EventParticipant.fromJson(Map<String, dynamic> json) => _$EventParticipantFromJson(json);

@override final  String? id;
@override final  String? eventId;
@override final  String name;
@override final  String phoneNumber;
@override final  String? positionOrGrade;
@override final  int desiredBudget;
 final  List<DateTime> _desiredDates;
@override@DateTimeListToTimestampListConverter() List<DateTime> get desiredDates {
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

 final  List<QuestionAnswer> _customQuestions;
@override@ListToMapConverter<QuestionAnswer>(prefix: 'custom-') List<QuestionAnswer> get customQuestions {
  if (_customQuestions is EqualUnmodifiableListView) return _customQuestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customQuestions);
}

 final  List<QuestionAnswer> _questions;
@override@ListToMapConverter<QuestionAnswer>(prefix: 'question-') List<QuestionAnswer> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  String allergiesEtc;
@override@CreatedAtField() final  DateTime? submittedAt;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventParticipant&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.positionOrGrade, positionOrGrade) || other.positionOrGrade == positionOrGrade)&&(identical(other.desiredBudget, desiredBudget) || other.desiredBudget == desiredBudget)&&const DeepCollectionEquality().equals(other._desiredDates, _desiredDates)&&const DeepCollectionEquality().equals(other._desiredLocations, _desiredLocations)&&const DeepCollectionEquality().equals(other._customQuestions, _customQuestions)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.allergiesEtc, allergiesEtc) || other.allergiesEtc == allergiesEtc)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,name,phoneNumber,positionOrGrade,desiredBudget,const DeepCollectionEquality().hash(_desiredDates),const DeepCollectionEquality().hash(_desiredLocations),const DeepCollectionEquality().hash(_customQuestions),const DeepCollectionEquality().hash(_questions),allergiesEtc,submittedAt,updatedAt);

@override
String toString() {
  return 'EventParticipant(id: $id, eventId: $eventId, name: $name, phoneNumber: $phoneNumber, positionOrGrade: $positionOrGrade, desiredBudget: $desiredBudget, desiredDates: $desiredDates, desiredLocations: $desiredLocations, customQuestions: $customQuestions, questions: $questions, allergiesEtc: $allergiesEtc, submittedAt: $submittedAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EventParticipantCopyWith<$Res> implements $EventParticipantCopyWith<$Res> {
  factory _$EventParticipantCopyWith(_EventParticipant value, $Res Function(_EventParticipant) _then) = __$EventParticipantCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? eventId, String name, String phoneNumber, String? positionOrGrade, int desiredBudget,@DateTimeListToTimestampListConverter() List<DateTime> desiredDates, List<String> desiredLocations,@ListToMapConverter<QuestionAnswer>(prefix: 'custom-') List<QuestionAnswer> customQuestions,@ListToMapConverter<QuestionAnswer>(prefix: 'question-') List<QuestionAnswer> questions, String allergiesEtc,@CreatedAtField() DateTime? submittedAt,@UpdatedAtField() DateTime? updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? eventId = freezed,Object? name = null,Object? phoneNumber = null,Object? positionOrGrade = freezed,Object? desiredBudget = null,Object? desiredDates = null,Object? desiredLocations = null,Object? customQuestions = null,Object? questions = null,Object? allergiesEtc = null,Object? submittedAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_EventParticipant(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,positionOrGrade: freezed == positionOrGrade ? _self.positionOrGrade : positionOrGrade // ignore: cast_nullable_to_non_nullable
as String?,desiredBudget: null == desiredBudget ? _self.desiredBudget : desiredBudget // ignore: cast_nullable_to_non_nullable
as int,desiredDates: null == desiredDates ? _self._desiredDates : desiredDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,desiredLocations: null == desiredLocations ? _self._desiredLocations : desiredLocations // ignore: cast_nullable_to_non_nullable
as List<String>,customQuestions: null == customQuestions ? _self._customQuestions : customQuestions // ignore: cast_nullable_to_non_nullable
as List<QuestionAnswer>,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuestionAnswer>,allergiesEtc: null == allergiesEtc ? _self.allergiesEtc : allergiesEtc // ignore: cast_nullable_to_non_nullable
as String,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$QuestionAnswer {

 String? get id; String get question; String get answer;
/// Create a copy of QuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionAnswerCopyWith<QuestionAnswer> get copyWith => _$QuestionAnswerCopyWithImpl<QuestionAnswer>(this as QuestionAnswer, _$identity);

  /// Serializes this QuestionAnswer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,answer);

@override
String toString() {
  return 'QuestionAnswer(id: $id, question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $QuestionAnswerCopyWith<$Res>  {
  factory $QuestionAnswerCopyWith(QuestionAnswer value, $Res Function(QuestionAnswer) _then) = _$QuestionAnswerCopyWithImpl;
@useResult
$Res call({
 String? id, String question, String answer
});




}
/// @nodoc
class _$QuestionAnswerCopyWithImpl<$Res>
    implements $QuestionAnswerCopyWith<$Res> {
  _$QuestionAnswerCopyWithImpl(this._self, this._then);

  final QuestionAnswer _self;
  final $Res Function(QuestionAnswer) _then;

/// Create a copy of QuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? question = null,Object? answer = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _QuestionAnswer implements QuestionAnswer {
  const _QuestionAnswer({this.id, required this.question, required this.answer});
  factory _QuestionAnswer.fromJson(Map<String, dynamic> json) => _$QuestionAnswerFromJson(json);

@override final  String? id;
@override final  String question;
@override final  String answer;

/// Create a copy of QuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionAnswerCopyWith<_QuestionAnswer> get copyWith => __$QuestionAnswerCopyWithImpl<_QuestionAnswer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionAnswerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,answer);

@override
String toString() {
  return 'QuestionAnswer(id: $id, question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$QuestionAnswerCopyWith<$Res> implements $QuestionAnswerCopyWith<$Res> {
  factory _$QuestionAnswerCopyWith(_QuestionAnswer value, $Res Function(_QuestionAnswer) _then) = __$QuestionAnswerCopyWithImpl;
@override @useResult
$Res call({
 String? id, String question, String answer
});




}
/// @nodoc
class __$QuestionAnswerCopyWithImpl<$Res>
    implements _$QuestionAnswerCopyWith<$Res> {
  __$QuestionAnswerCopyWithImpl(this._self, this._then);

  final _QuestionAnswer _self;
  final $Res Function(_QuestionAnswer) _then;

/// Create a copy of QuestionAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? question = null,Object? answer = null,}) {
  return _then(_QuestionAnswer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
