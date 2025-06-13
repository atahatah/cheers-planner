// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate_area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CandidateArea {

 double get latitude; double get longitude; double get radius;
/// Create a copy of CandidateArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateAreaCopyWith<CandidateArea> get copyWith => _$CandidateAreaCopyWithImpl<CandidateArea>(this as CandidateArea, _$identity);

  /// Serializes this CandidateArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateArea&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,radius);

@override
String toString() {
  return 'CandidateArea(latitude: $latitude, longitude: $longitude, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $CandidateAreaCopyWith<$Res>  {
  factory $CandidateAreaCopyWith(CandidateArea value, $Res Function(CandidateArea) _then) = _$CandidateAreaCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double radius
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
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? radius = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CandidateArea implements CandidateArea {
  const _CandidateArea({required this.latitude, required this.longitude, required this.radius});
  factory _CandidateArea.fromJson(Map<String, dynamic> json) => _$CandidateAreaFromJson(json);

@override final  double latitude;
@override final  double longitude;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateArea&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,radius);

@override
String toString() {
  return 'CandidateArea(latitude: $latitude, longitude: $longitude, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$CandidateAreaCopyWith<$Res> implements $CandidateAreaCopyWith<$Res> {
  factory _$CandidateAreaCopyWith(_CandidateArea value, $Res Function(_CandidateArea) _then) = __$CandidateAreaCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double radius
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
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? radius = null,}) {
  return _then(_CandidateArea(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
