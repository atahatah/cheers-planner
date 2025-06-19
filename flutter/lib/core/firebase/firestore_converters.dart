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

class DateTimeListToTimestampListConverter
    implements JsonConverter<List<DateTime>, List<dynamic>> {
  const DateTimeListToTimestampListConverter();

  @override
  List<DateTime> fromJson(List<dynamic> timestamps) {
    return timestamps.map((e) => (e as Timestamp).toDate()).toList();
  }

  @override
  List<Timestamp> toJson(List<DateTime> dates) {
    return dates.map(Timestamp.fromDate).toList();
  }
}

class GeoPointToJsonConverter implements JsonConverter<GeoPoint, GeoPoint> {
  const GeoPointToJsonConverter();

  @override
  GeoPoint fromJson(GeoPoint geoPoint) {
    return geoPoint;
  }

  @override
  GeoPoint toJson(GeoPoint geoPoint) {
    return geoPoint;
  }
}

class GeoPointListToJsonConverter
    implements JsonConverter<List<GeoPoint>, List<GeoPoint>> {
  const GeoPointListToJsonConverter();

  @override
  List<GeoPoint> fromJson(List<GeoPoint> geoPoints) {
    return geoPoints;
  }

  @override
  List<GeoPoint> toJson(List<GeoPoint> geoPoints) {
    return geoPoints;
  }
}
