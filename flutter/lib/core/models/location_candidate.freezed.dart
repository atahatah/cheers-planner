// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_candidate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationCandidate {

 String get name; LocationCenter get center; double get radius; String get reason; String get suitableFor;
/// Create a copy of LocationCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCandidateCopyWith<LocationCandidate> get copyWith => _$LocationCandidateCopyWithImpl<LocationCandidate>(this as LocationCandidate, _$identity);

  /// Serializes this LocationCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationCandidate&&(identical(other.name, name) || other.name == name)&&(identical(other.center, center) || other.center == center)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.suitableFor, suitableFor) || other.suitableFor == suitableFor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,center,radius,reason,suitableFor);

@override
String toString() {
  return 'LocationCandidate(name: $name, center: $center, radius: $radius, reason: $reason, suitableFor: $suitableFor)';
}


}

/// @nodoc
abstract mixin class $LocationCandidateCopyWith<$Res>  {
  factory $LocationCandidateCopyWith(LocationCandidate value, $Res Function(LocationCandidate) _then) = _$LocationCandidateCopyWithImpl;
@useResult
$Res call({
 String name, LocationCenter center, double radius, String reason, String suitableFor
});


$LocationCenterCopyWith<$Res> get center;

}
/// @nodoc
class _$LocationCandidateCopyWithImpl<$Res>
    implements $LocationCandidateCopyWith<$Res> {
  _$LocationCandidateCopyWithImpl(this._self, this._then);

  final LocationCandidate _self;
  final $Res Function(LocationCandidate) _then;

/// Create a copy of LocationCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? center = null,Object? radius = null,Object? reason = null,Object? suitableFor = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as LocationCenter,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,suitableFor: null == suitableFor ? _self.suitableFor : suitableFor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of LocationCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCenterCopyWith<$Res> get center {
  
  return $LocationCenterCopyWith<$Res>(_self.center, (value) {
    return _then(_self.copyWith(center: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _LocationCandidate implements LocationCandidate {
  const _LocationCandidate({required this.name, required this.center, required this.radius, required this.reason, required this.suitableFor});
  factory _LocationCandidate.fromJson(Map<String, dynamic> json) => _$LocationCandidateFromJson(json);

@override final  String name;
@override final  LocationCenter center;
@override final  double radius;
@override final  String reason;
@override final  String suitableFor;

/// Create a copy of LocationCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCandidateCopyWith<_LocationCandidate> get copyWith => __$LocationCandidateCopyWithImpl<_LocationCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationCandidate&&(identical(other.name, name) || other.name == name)&&(identical(other.center, center) || other.center == center)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.suitableFor, suitableFor) || other.suitableFor == suitableFor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,center,radius,reason,suitableFor);

@override
String toString() {
  return 'LocationCandidate(name: $name, center: $center, radius: $radius, reason: $reason, suitableFor: $suitableFor)';
}


}

/// @nodoc
abstract mixin class _$LocationCandidateCopyWith<$Res> implements $LocationCandidateCopyWith<$Res> {
  factory _$LocationCandidateCopyWith(_LocationCandidate value, $Res Function(_LocationCandidate) _then) = __$LocationCandidateCopyWithImpl;
@override @useResult
$Res call({
 String name, LocationCenter center, double radius, String reason, String suitableFor
});


@override $LocationCenterCopyWith<$Res> get center;

}
/// @nodoc
class __$LocationCandidateCopyWithImpl<$Res>
    implements _$LocationCandidateCopyWith<$Res> {
  __$LocationCandidateCopyWithImpl(this._self, this._then);

  final _LocationCandidate _self;
  final $Res Function(_LocationCandidate) _then;

/// Create a copy of LocationCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? center = null,Object? radius = null,Object? reason = null,Object? suitableFor = null,}) {
  return _then(_LocationCandidate(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as LocationCenter,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,suitableFor: null == suitableFor ? _self.suitableFor : suitableFor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of LocationCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCenterCopyWith<$Res> get center {
  
  return $LocationCenterCopyWith<$Res>(_self.center, (value) {
    return _then(_self.copyWith(center: value));
  });
}
}


/// @nodoc
mixin _$LocationCenter {

 double get lat; double get lng;
/// Create a copy of LocationCenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCenterCopyWith<LocationCenter> get copyWith => _$LocationCenterCopyWithImpl<LocationCenter>(this as LocationCenter, _$identity);

  /// Serializes this LocationCenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationCenter&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lng);

@override
String toString() {
  return 'LocationCenter(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class $LocationCenterCopyWith<$Res>  {
  factory $LocationCenterCopyWith(LocationCenter value, $Res Function(LocationCenter) _then) = _$LocationCenterCopyWithImpl;
@useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class _$LocationCenterCopyWithImpl<$Res>
    implements $LocationCenterCopyWith<$Res> {
  _$LocationCenterCopyWithImpl(this._self, this._then);

  final LocationCenter _self;
  final $Res Function(LocationCenter) _then;

/// Create a copy of LocationCenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LocationCenter extends LocationCenter {
  const _LocationCenter({required this.lat, required this.lng}): super._();
  factory _LocationCenter.fromJson(Map<String, dynamic> json) => _$LocationCenterFromJson(json);

@override final  double lat;
@override final  double lng;

/// Create a copy of LocationCenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCenterCopyWith<_LocationCenter> get copyWith => __$LocationCenterCopyWithImpl<_LocationCenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationCenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationCenter&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lng);

@override
String toString() {
  return 'LocationCenter(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$LocationCenterCopyWith<$Res> implements $LocationCenterCopyWith<$Res> {
  factory _$LocationCenterCopyWith(_LocationCenter value, $Res Function(_LocationCenter) _then) = __$LocationCenterCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class __$LocationCenterCopyWithImpl<$Res>
    implements _$LocationCenterCopyWith<$Res> {
  __$LocationCenterCopyWithImpl(this._self, this._then);

  final _LocationCenter _self;
  final $Res Function(_LocationCenter) _then;

/// Create a copy of LocationCenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_LocationCenter(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$LocationCandidateRequest {

 List<String> get desiredLocations; List<String> get participantPositions; int get budgetUpperLimit; String get purpose; List<String> get specialConsiderations;
/// Create a copy of LocationCandidateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCandidateRequestCopyWith<LocationCandidateRequest> get copyWith => _$LocationCandidateRequestCopyWithImpl<LocationCandidateRequest>(this as LocationCandidateRequest, _$identity);

  /// Serializes this LocationCandidateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationCandidateRequest&&const DeepCollectionEquality().equals(other.desiredLocations, desiredLocations)&&const DeepCollectionEquality().equals(other.participantPositions, participantPositions)&&(identical(other.budgetUpperLimit, budgetUpperLimit) || other.budgetUpperLimit == budgetUpperLimit)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&const DeepCollectionEquality().equals(other.specialConsiderations, specialConsiderations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(desiredLocations),const DeepCollectionEquality().hash(participantPositions),budgetUpperLimit,purpose,const DeepCollectionEquality().hash(specialConsiderations));

@override
String toString() {
  return 'LocationCandidateRequest(desiredLocations: $desiredLocations, participantPositions: $participantPositions, budgetUpperLimit: $budgetUpperLimit, purpose: $purpose, specialConsiderations: $specialConsiderations)';
}


}

/// @nodoc
abstract mixin class $LocationCandidateRequestCopyWith<$Res>  {
  factory $LocationCandidateRequestCopyWith(LocationCandidateRequest value, $Res Function(LocationCandidateRequest) _then) = _$LocationCandidateRequestCopyWithImpl;
@useResult
$Res call({
 List<String> desiredLocations, List<String> participantPositions, int budgetUpperLimit, String purpose, List<String> specialConsiderations
});




}
/// @nodoc
class _$LocationCandidateRequestCopyWithImpl<$Res>
    implements $LocationCandidateRequestCopyWith<$Res> {
  _$LocationCandidateRequestCopyWithImpl(this._self, this._then);

  final LocationCandidateRequest _self;
  final $Res Function(LocationCandidateRequest) _then;

/// Create a copy of LocationCandidateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? desiredLocations = null,Object? participantPositions = null,Object? budgetUpperLimit = null,Object? purpose = null,Object? specialConsiderations = null,}) {
  return _then(_self.copyWith(
desiredLocations: null == desiredLocations ? _self.desiredLocations : desiredLocations // ignore: cast_nullable_to_non_nullable
as List<String>,participantPositions: null == participantPositions ? _self.participantPositions : participantPositions // ignore: cast_nullable_to_non_nullable
as List<String>,budgetUpperLimit: null == budgetUpperLimit ? _self.budgetUpperLimit : budgetUpperLimit // ignore: cast_nullable_to_non_nullable
as int,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,specialConsiderations: null == specialConsiderations ? _self.specialConsiderations : specialConsiderations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LocationCandidateRequest implements LocationCandidateRequest {
  const _LocationCandidateRequest({required final  List<String> desiredLocations, required final  List<String> participantPositions, required this.budgetUpperLimit, required this.purpose, required final  List<String> specialConsiderations}): _desiredLocations = desiredLocations,_participantPositions = participantPositions,_specialConsiderations = specialConsiderations;
  factory _LocationCandidateRequest.fromJson(Map<String, dynamic> json) => _$LocationCandidateRequestFromJson(json);

 final  List<String> _desiredLocations;
@override List<String> get desiredLocations {
  if (_desiredLocations is EqualUnmodifiableListView) return _desiredLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_desiredLocations);
}

 final  List<String> _participantPositions;
@override List<String> get participantPositions {
  if (_participantPositions is EqualUnmodifiableListView) return _participantPositions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantPositions);
}

@override final  int budgetUpperLimit;
@override final  String purpose;
 final  List<String> _specialConsiderations;
@override List<String> get specialConsiderations {
  if (_specialConsiderations is EqualUnmodifiableListView) return _specialConsiderations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specialConsiderations);
}


/// Create a copy of LocationCandidateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCandidateRequestCopyWith<_LocationCandidateRequest> get copyWith => __$LocationCandidateRequestCopyWithImpl<_LocationCandidateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationCandidateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationCandidateRequest&&const DeepCollectionEquality().equals(other._desiredLocations, _desiredLocations)&&const DeepCollectionEquality().equals(other._participantPositions, _participantPositions)&&(identical(other.budgetUpperLimit, budgetUpperLimit) || other.budgetUpperLimit == budgetUpperLimit)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&const DeepCollectionEquality().equals(other._specialConsiderations, _specialConsiderations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_desiredLocations),const DeepCollectionEquality().hash(_participantPositions),budgetUpperLimit,purpose,const DeepCollectionEquality().hash(_specialConsiderations));

@override
String toString() {
  return 'LocationCandidateRequest(desiredLocations: $desiredLocations, participantPositions: $participantPositions, budgetUpperLimit: $budgetUpperLimit, purpose: $purpose, specialConsiderations: $specialConsiderations)';
}


}

/// @nodoc
abstract mixin class _$LocationCandidateRequestCopyWith<$Res> implements $LocationCandidateRequestCopyWith<$Res> {
  factory _$LocationCandidateRequestCopyWith(_LocationCandidateRequest value, $Res Function(_LocationCandidateRequest) _then) = __$LocationCandidateRequestCopyWithImpl;
@override @useResult
$Res call({
 List<String> desiredLocations, List<String> participantPositions, int budgetUpperLimit, String purpose, List<String> specialConsiderations
});




}
/// @nodoc
class __$LocationCandidateRequestCopyWithImpl<$Res>
    implements _$LocationCandidateRequestCopyWith<$Res> {
  __$LocationCandidateRequestCopyWithImpl(this._self, this._then);

  final _LocationCandidateRequest _self;
  final $Res Function(_LocationCandidateRequest) _then;

/// Create a copy of LocationCandidateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? desiredLocations = null,Object? participantPositions = null,Object? budgetUpperLimit = null,Object? purpose = null,Object? specialConsiderations = null,}) {
  return _then(_LocationCandidateRequest(
desiredLocations: null == desiredLocations ? _self._desiredLocations : desiredLocations // ignore: cast_nullable_to_non_nullable
as List<String>,participantPositions: null == participantPositions ? _self._participantPositions : participantPositions // ignore: cast_nullable_to_non_nullable
as List<String>,budgetUpperLimit: null == budgetUpperLimit ? _self.budgetUpperLimit : budgetUpperLimit // ignore: cast_nullable_to_non_nullable
as int,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,specialConsiderations: null == specialConsiderations ? _self._specialConsiderations : specialConsiderations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
