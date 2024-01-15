import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:exploree_pal/features/home/domain/entity/places_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/constants/app_textstyle_theme.dart';

class AboutPlaceView extends ConsumerStatefulWidget {
  const AboutPlaceView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutPlaceViewState();
}

class _AboutPlaceViewState extends ConsumerState<AboutPlaceView> {
  PlacesDetails? placesDetails;

  @override
  void initState() {
    watchListCase();
    super.initState();
  }

  watchListCase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isWatchListed = prefs.getBool('isWatchListed');
    if (isWatchListed != null) {
      placesDetails!.isWatchListed = isWatchListed;
    }
  }

  @override
  void didChangeDependencies() {
    placesDetails =
        ModalRoute.of(context)!.settings.arguments as PlacesDetails?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bodyColors,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.bodyColors,
            expandedHeight: screenHeight * 0.35,
            pinned: true,
            collapsedHeight: screenHeight * 0.1,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.bodyColors,
              ),
            ),
            flexibleSpace: Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Image.network(
                placesDetails!.placeImage!.isEmpty
                    ? "      https://picknepal.com/wp-content/uploads/2020/06/Rara-Lake-1.jpg"
                    : placesDetails!.placeImage!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.01,
                          right: screenWidth * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              placesDetails!.placeTitle!.isEmpty
                                  ? ""
                                  : placesDetails!.placeTitle!,
                              style: AppTextStyle.poppinsBold20,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  placesDetails!.isWatchListed =
                                      !placesDetails!.isWatchListed!;

                                  final Future<SharedPreferences> prefs =
                                      SharedPreferences.getInstance();

                                  prefs.then(
                                    (value) => {
                                      value.setBool(
                                        'isWatchListed',
                                        placesDetails!.isWatchListed!,
                                      )
                                    },
                                  );
                                });
                              },
                              icon: placesDetails!.isWatchListed!
                                  ? Icon(
                                      Icons.bookmark,
                                      size: 25,
                                      color: AppColors.ratingColors,
                                    )
                                  : Icon(
                                      Icons.bookmark_outline_outlined,
                                      size: 25,
                                      color: AppColors.ratingColors,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 25,
                            color: AppColors.ratingColors,
                          ),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          Text(
                            placesDetails!.placeLocation!.isEmpty
                                ? ""
                                : placesDetails!.placeLocation!,
                            style: AppTextStyle.poppinsMedium15.copyWith(
                              color: AppColors.secondaryColors,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.004),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.01,
                            ),
                            Text(
                              placesDetails!.placeRating!.toString(),
                              style: AppTextStyle.poppinsMedium15.copyWith(
                                color: AppColors.secondaryColors,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            for (double i = 0;
                                i < placesDetails!.placeRating!;
                                i++)
                              Icon(
                                Icons.star,
                                size: 15,
                                color: AppColors.ratingColors,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          dividerColor: AppColors.appbarColors,
                          labelPadding: EdgeInsets.only(
                            left: screenWidth * 0.01,
                            right: screenWidth * 0.15,
                          ),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          indicatorColor: AppColors.tabColors,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 3,
                          labelColor: AppColors.tabColors,
                          unselectedLabelColor:
                              AppColors.secondaryColors.withOpacity(0.5),
                          labelStyle: AppTextStyle.poppins15,
                          tabs: const [
                            Tab(
                              text: "About",
                            ),
                            Tab(
                              text: "Photos",
                            ),
                            Tab(
                              text: "Videos",
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.01,
                          ),
                          child: SizedBox(
                            height: screenHeight * 0.9,
                            child: TabBarView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description',
                                      style: AppTextStyle.poppinsSemiBold18,
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Text(
                                      placesDetails!.placeDescription!.isEmpty
                                          ? ""
                                          : placesDetails!.placeDescription!,
                                      style:
                                          AppTextStyle.poppinsMedium15.copyWith(
                                        color: AppColors.secondaryColors,
                                      ),
                                      maxLines: 8,
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SizedBox(
                                        height: screenHeight * 0.06,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.tabColors,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          child: Text(
                                            'View Route',
                                            style: AppTextStyle
                                                .poppinsSemiBold18
                                                .copyWith(
                                              color: AppColors.bodyColors,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Text('Photos'),
                                const Text('Videos'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
