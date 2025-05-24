// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEntry _$UserEntryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_UserEntry', json, ($checkedConvert) {
  final val = _UserEntry(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    photoUrl: $checkedConvert('photoUrl', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$UserEntryToJson(_UserEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
