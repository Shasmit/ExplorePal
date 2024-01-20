// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchListApiModel _$WatchListApiModelFromJson(Map<String, dynamic> json) =>
    WatchListApiModel(
      id: json['_id'] as String,
      user: json['user'] as String,
      placeDetails: PlaceDetailsApiModel.fromJson(
          json['placeDetails'] as Map<String, dynamic>),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$WatchListApiModelToJson(WatchListApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'placeDetails': instance.placeDetails.toJson(),
      '__v': instance.v,
    };

PlaceDetailsApiModel _$PlaceDetailsApiModelFromJson(
        Map<String, dynamic> json) =>
    PlaceDetailsApiModel(
      title: json['title'] as String,
      poster: json['poster'] as String,
      id: json['id'] as String,
      iid: json['_id'] as String,
    );

Map<String, dynamic> _$PlaceDetailsApiModelToJson(
        PlaceDetailsApiModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'poster': instance.poster,
      'id': instance.id,
      '_id': instance.iid,
    };
