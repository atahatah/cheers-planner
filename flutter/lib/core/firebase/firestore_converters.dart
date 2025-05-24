import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class CreatedAtField implements JsonConverter<DateTime?, dynamic> {
  const CreatedAtField();

  @override
  DateTime? fromJson(dynamic timestamp) {
    timestamp as Timestamp?;
    return timestamp?.toDate();
  }

  @override
  dynamic toJson(DateTime? dateTime) {
    if (dateTime == null) {
      return FieldValue.serverTimestamp();
    }
    return dateTime;
  }
}

class UpdatedAtField implements JsonConverter<DateTime?, dynamic> {
  const UpdatedAtField();

  @override
  DateTime? fromJson(dynamic timestamp) {
    timestamp as Timestamp?;
    return timestamp?.toDate();
  }

  @override
  FieldValue toJson(DateTime? date) {
    return FieldValue.serverTimestamp();
  }
}

class DateTimeToTimestampConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeToTimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    timestamp as Timestamp;
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) {
    return Timestamp.fromDate(date);
  }
}

class NullableDateTimeToTimestampConverter
    implements JsonConverter<DateTime?, dynamic> {
  const NullableDateTimeToTimestampConverter();

  @override
  DateTime? fromJson(dynamic timestamp) {
    timestamp as Timestamp?;
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) {
    return date == null ? null : Timestamp.fromDate(date);
  }
}
