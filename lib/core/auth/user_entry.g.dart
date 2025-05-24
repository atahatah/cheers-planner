// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEntry _$UserEntryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_UserEntry', json, ($checkedConvert) {
      final val = _UserEntry(
        id: $checkedConvert('id', (v) => v as String?),
        birthday: $checkedConvert(
          'birthday',
          (v) => const NullableDateTimeToTimestampConverter().fromJson(v),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const CreatedAtField().fromJson(v),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UpdatedAtField().fromJson(v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UserEntryToJson(_UserEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'birthday': const NullableDateTimeToTimestampConverter().toJson(
        instance.birthday,
      ),
      'createdAt': const CreatedAtField().toJson(instance.createdAt),
      'updatedAt': const UpdatedAtField().toJson(instance.updatedAt),
    };
