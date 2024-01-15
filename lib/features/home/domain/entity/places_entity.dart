import 'package:flutter_riverpod/flutter_riverpod.dart';

final allPlacesModelProvider = Provider<PlacesDetails>((ref) {
  return PlacesDetails.empty();
});

class PlacesDetails {
  int? id;
  String? placeImage;
  String? placeTitle;
  double? placeRating;
  String? placeLocation;
  String? placeDescription;
  List<String>? placePhoto;
  String? placeVideo;

  bool? isWatchListed;

  PlacesDetails({
    this.id,
    this.placeImage,
    this.placeTitle,
    this.placeRating,
    this.placeLocation,
    this.placeDescription,
    this.placePhoto,
    this.placeVideo,
    this.isWatchListed,
  });

  PlacesDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeImage = json['place_image'];
    placeTitle = json['place_title'];
    placeRating = json['place_rating'];
    placeLocation = json['place_location'];
    placeDescription = json['place_description'];
    placePhoto = json['place_photo'].cast<String>();
    placeVideo = json['place_video'];
    isWatchListed = json['isWatchListed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['place_image'] = placeImage;
    data['place_title'] = placeTitle;
    data['place_rating'] = placeRating;
    data['place_location'] = placeLocation;
    data['place_description'] = placeDescription;
    data['place_photo'] = placePhoto;
    data['place_video'] = placeVideo;
    data['isWatchListed'] = isWatchListed;
    return data;
  }

  PlacesDetails.empty() {
    id = 0;
    placeImage = '';
    placeTitle = '';
    placeRating = 0.0;
    placeLocation = '';
    placeDescription = '';
    placePhoto = [];
    placeVideo = '';
    isWatchListed = false;
  }

  @override
  String toString() {
    return 'id: $id placeImage: $placeImage, placeTitle: $placeTitle, placeRating: $placeRating, placeLocation: $placeLocation, placeDescription: $placeDescription, placePhoto: $placePhoto, placeVideo: $placeVideo, isWatchListed: $isWatchListed';
  }
}
