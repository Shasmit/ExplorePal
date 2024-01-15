import 'dart:convert';

import 'package:exploree_pal/features/home/domain/entity/places_entity.dart';
import 'package:flutter/services.dart';

Future<List<PlacesDetails>> getPlaceLocalDetails() async {
  final response = await rootBundle.loadString('test_data/data.json');
  final jsonList = await json.decode(response);

  final List<PlacesDetails> movieList = jsonList
      .map<PlacesDetails>(
        (json) => PlacesDetails.fromJson(json),
      )
      .toList();

  return Future.value(movieList);
}
