import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/watchlist_entity.dart';

part 'watchlist_api_model.g.dart';

final watchListApiModelProvider = Provider<WatchListApiModel>(
  (ref) => WatchListApiModel.empty(),
);

@JsonSerializable()
class WatchListApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'user')
  final String user;

  @JsonKey(name: 'placeDetails')
  final PlaceDetailsApiModel placeDetails;

  @JsonKey(name: '__v')
  final int v;

  const WatchListApiModel({
    required this.id,
    required this.user,
    required this.placeDetails,
    required this.v,
  });

  factory WatchListApiModel.fromJson(Map<String, dynamic> json) =>
      _$WatchListApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WatchListApiModelToJson(this);

  factory WatchListApiModel.empty() => WatchListApiModel(
        id: '',
        user: '',
        placeDetails: PlaceDetailsApiModel.empty(),
        v: 0,
      );

  WatchListEntity toEntity() => WatchListEntity(
        id: id,
        user: user,
        placeDetails: placeDetails.toEntity(),
        v: v,
      );

  WatchListApiModel fromEntity(WatchListEntity entity) => WatchListApiModel(
        id: entity.id,
        user: entity.user,
        placeDetails:
            PlaceDetailsApiModel.empty().fromEntity(entity.placeDetails),
        v: entity.v,
      );

  List<WatchListEntity> toEntityList(List<WatchListApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        user,
        placeDetails,
        v,
      ];
}

@JsonSerializable()
class PlaceDetailsApiModel extends Equatable {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'poster')
  final String poster;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: '_id')
  final String iid;

  const PlaceDetailsApiModel({
    required this.title,
    required this.poster,
    required this.id,
    required this.iid,
  });

  factory PlaceDetailsApiModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailsApiModelToJson(this);

  factory PlaceDetailsApiModel.empty() => const PlaceDetailsApiModel(
        title: '',
        poster: '',
        id: '',
        iid: '',
      );

  PlaceDetails toEntity() => PlaceDetails(
        title: title,
        poster: poster,
        id: id,
        iid: iid,
      );

  PlaceDetailsApiModel fromEntity(PlaceDetails entity) => PlaceDetailsApiModel(
        title: entity.title,
        poster: entity.poster,
        id: entity.id,
        iid: entity.iid,
      );

  List<PlaceDetails> toEntityList(List<PlaceDetailsApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        title,
        poster,
        id,
        iid,
      ];
}
