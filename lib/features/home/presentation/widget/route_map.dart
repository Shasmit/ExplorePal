import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:exploree_pal/features/home/presentation/widget/map_utils.dart';
import 'package:exploree_pal/features/home/presentation/widget/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_textstyle_theme.dart';
import '../../../profile/presentation/viewmodel/profile_view_model.dart';

class RouteMapView extends ConsumerStatefulWidget {
  const RouteMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RouteMapViewState();
}

class _RouteMapViewState extends ConsumerState<RouteMapView> {
  late GoogleMapController _controller;

  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;

  late CameraPosition _initialCameraPosition;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  String? endPositionLat;
  String? endPositionLon;
  String? destinationTitle;

  @override
  void didChangeDependencies() {
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      endPositionLat = arguments['lat'];
      endPositionLon = arguments['lon'];
      destinationTitle = arguments['title'];
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _onAddMarkerButtonPressed();
    _initialCameraPosition = CameraPosition(
      target: LatLng(double.parse(StaticVariable.currentLat),
          double.parse(StaticVariable.currentLon)),
      zoom: 16.0,
    );
  }

  _addPolyLine() {
    LatLng currentLocation = LatLng(double.parse(StaticVariable.currentLat),
        double.parse(StaticVariable.currentLon));

    LatLng destinationLocation =
        LatLng(double.parse(endPositionLat!), double.parse(endPositionLon!));
    PolylineId id = const PolylineId("destination route");
    Polyline polyline = Polyline(
      startCap: Cap.squareCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
      patterns: [PatternItem.dash(20), PatternItem.gap(10)],
      polylineId: id,
      color: AppColors.ratingColors,
      points: [currentLocation, destinationLocation],
      width: 2,
    );
    polylines[id] = polyline;

    setState(() {});
  }

  // _getPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       'AIzaSyDmMzGmGbjESph5OSbXVTktwB3OkVd6W18',
  //       PointLatLng(double.parse(StaticVariable.currentLat),
  //           double.parse(StaticVariable.currentLon)),
  //       PointLatLng(
  //           double.parse(endPositionLat!), double.parse(endPositionLon!)),
  //       travelMode: TravelMode.driving);
  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     }
  //   } else {
  //     print("No route found");
  //   }
  //   _addPolyLine();
  // }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.terrain : MapType.normal;
    });
  }

  Future<void> _onAddMarkerButtonPressed() async {
    final ByteData data = await rootBundle.load(
      'assets/icons/destination.png',
    );
    final Uint8List bytes = data.buffer.asUint8List();

    final BitmapDescriptor destinationIcon = BitmapDescriptor.fromBytes(bytes);

    final ByteData data2 = await rootBundle.load(
      'assets/icons/start_trip.png',
    );
    final Uint8List bytes1 = data2.buffer.asUint8List();

    final BitmapDescriptor startIcon = BitmapDescriptor.fromBytes(bytes1);

    setState(() {
      // Get current location

      // Add the first marker (current location)

      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(double.parse(StaticVariable.currentLat),
              double.parse(StaticVariable.currentLon)),
          infoWindow: const InfoWindow(
            title: 'Current Location',
            snippet: 'This is your current location',
          ),
          icon: destinationIcon,
        ),
      );

      _controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(double.parse(StaticVariable.currentLat),
            double.parse(StaticVariable.currentLon)),
        16.0,
      ));

      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: const MarkerId('destination'),
        position: LatLng(
            double.parse(endPositionLat!), double.parse(endPositionLon!)),
        infoWindow: InfoWindow(
          title: '$destinationTitle',
          snippet: '$destinationTitle is your destination',
        ),
        icon: startIcon,
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;

    _onAddMarkerButtonPressed();

    if (_markers.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 200), () {
        controller.animateCamera(
          CameraUpdate.newLatLngBounds(
            MapUtils.boundsFromLatLngList(
              _markers.map((loc) => loc.position).toList(),
            ),
            1,
          ),
        );
        _addPolyLine();
      });
    }

    String value = await DefaultAssetBundle.of(context)
        .loadString('test_data/map_style.json');
    _controller.setMapStyle(value);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final profileState = ref.watch(profileViewModelProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: screenHeight * 0.2,
        backgroundColor: AppColors.appbarColors,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Image.asset(
                    "assets/icons/menu30.png",
                  ),
                ),
                Text(
                  "Destination Map",
                  style: AppTextStyle.poppinsSemiBold22.copyWith(
                    color: AppColors.secondaryColors,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: .5,
                        blurRadius: 6,
                        offset: const Offset(.5, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.bodyColors,
                    foregroundColor: Colors.transparent,
                    child: ClipOval(
                      child: profileState.user[0].image != null
                          ? Image.network(
                              // Use Image.network for API-provided image
                              '${ApiEndpoints.baseUrl}/uploads/${profileState.user[0].image}',
                              fit: BoxFit.cover,
                              width: 100.0,
                              height: 100.0,
                            )
                          : Image.asset(
                              "assets/icons/user.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shortest Route',
                    style: AppTextStyle.poppinsBold25,
                  ),
                  Text(
                    'To Your Destination',
                    style: AppTextStyle.poppinsSemiBold20.copyWith(
                      color: const Color(0xff6F7789),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            polylines: Set<Polyline>.of(polylines.values),
            markers: _markers,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialCameraPosition,
            mapType: _currentMapType,
            trafficEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: AppColors.buttonColors,
                    foregroundColor: AppColors.bodyColors,
                    child: const Icon(Icons.map, size: 30.0),
                  ),
                  const SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: AppColors.buttonColors,
                    foregroundColor: AppColors.bodyColors,
                    child: const Icon(Icons.add_location, size: 30.0),
                  ),
                  const SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Given in the map is the shortest route to $destinationTitle",
                                style: AppTextStyle.poppinsMedium18.copyWith(
                                  color: AppColors.buttonColors,
                                ),
                              ),
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: Text(
                                  "OK",
                                  style: AppTextStyle.poppinsMedium15,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: AppColors.buttonColors,
                    foregroundColor: AppColors.bodyColors,
                    child: const Icon(Icons.info, size: 30.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
