import 'package:cheers_planner/core/firebase/firestore_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entry.freezed.dart';
part 'user_entry.g.dart';

@freezed
sealed class UserEntry with _$UserEntry {
  const factory UserEntry({
    String? id,
    @NullableDateTimeToTimestampConverter() DateTime? birthday,
    @CreatedAtField() DateTime? createdAt,
    @UpdatedAtField() DateTime? updatedAt,
  }) = _UserEntry;

  factory UserEntry.fromJson(Map<String, dynamic> json) =>
      _$UserEntryFromJson(json);
}
