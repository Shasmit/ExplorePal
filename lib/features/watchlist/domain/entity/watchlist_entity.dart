import 'package:equatable/equatable.dart';

class WatchListEntity extends Equatable {
  final String id;
  final String user;
  final PlaceDetails placeDetails;
  final int v;

  const WatchListEntity({
    required this.id,
    required this.user,
    required this.placeDetails,
    required this.v,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        placeDetails,
        v,
      ];

  factory WatchListEntity.fromJson(Map<String, dynamic> json) =>
      WatchListEntity(
        id: json["_id"],
        user: json["user"],
        placeDetails: PlaceDetails.fromJson(json["placeDetails"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "placeDetails": placeDetails.toJson(),
        "__v": v,
      };
}

class PlaceDetails extends Equatable {
  final String title;
  final String poster;
  final String id;
  final String iid;

  const PlaceDetails({
    required this.title,
    required this.poster,
    required this.id,
    required this.iid,
  });

  const PlaceDetails.empty()
      : this(
          title: '',
          poster: '',
          id: '',
          iid: '',
        );

  factory PlaceDetails.fromJson(Map<String, dynamic> json) => PlaceDetails(
        title: json["title"],
        poster: json["poster"],
        id: json["id"],
        iid: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "poster": poster,
        "id": id,
        "_id": iid,
      };

  @override
  List<Object?> get props => [
        title,
        poster,
        id,
        iid,
      ];
}
