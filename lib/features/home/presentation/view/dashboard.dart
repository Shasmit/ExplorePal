import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:exploree_pal/config/constants/app_textstyle_theme.dart';
import 'package:exploree_pal/config/router/app_route.dart';
import 'package:exploree_pal/core/common/widget/injection_container.dart';
import 'package:exploree_pal/features/home/domain/entity/places_entity.dart';
import 'package:exploree_pal/features/home/presentation/bloc/place_bloc.dart';
import 'package:exploree_pal/features/home/presentation/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardView extends ConsumerStatefulWidget {
  const DashBoardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends ConsumerState<DashBoardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final PlaceDetailsBloc _blocReference = sl<PlaceDetailsBloc>();

  List<PlacesDetails> placesDetails = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // List<String> imageList = [
    //   "https://picknepal.com/wp-content/uploads/2020/06/Rara-Lake-1.jpg",
    //   "https://upload.wikimedia.org/wikipedia/commons/a/ae/Rara_lake%2C_Mugu.jpg",
    //   "https://web.nepalnews.com/storage/story/1024/image_1607335331_1024.jpg",
    //   'https://imagepasal.com/wp-content/uploads/2022/03/F3EE020E-07D4-4F08-8E9D-D5FB9F7A0B4B-image-pasal-2022-03-15.jpeg',
    // ];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerView(),
        backgroundColor: AppColors.bodyColors,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: screenHeight * 0.25,
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
                    "Home",
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
                      foregroundImage: const AssetImage(
                        "assets/icons/user.png",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.035,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wonderful Nepal',
                      style: AppTextStyle.poppinsBold25,
                    ),
                    Text(
                      'Let\'s explore together',
                      style: AppTextStyle.poppinsSemiBold20.copyWith(
                        color: const Color(0xff6F7789),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottom: TabBar(
            dividerColor: AppColors.appbarColors,
            labelPadding: EdgeInsets.only(
              left: screenWidth * 0.06,
              right: screenWidth * 0.06,
            ),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppColors.tabColors,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            labelColor: AppColors.tabColors,
            unselectedLabelColor: AppColors.secondaryColors.withOpacity(0.5),
            labelStyle: AppTextStyle.poppins13,
            tabs: const [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Popular",
              ),
              Tab(
                text: "Nearby",
              ),
              Tab(
                text: "Recommended",
              ),
            ],
          ),
        ),
        body: BlocProvider<PlaceDetailsBloc>(
          create: (context) => _blocReference..add(PlaceDetailsInit()),
          child: BlocListener<PlaceDetailsBloc, PlaceDetailsState>(
            bloc: _blocReference,
            listener: (context, state) {
              if (state is PlaceDetailsError) {
                ScaffoldMessenger.of(context).showSnackBar(state.snackBar);
              }
              if (state is PlaceDetailsLoading) {
                const CircularProgressIndicator();
              }
              if (state is PlaceDetailsLoaded) {
                const CircularProgressIndicator();
                placesDetails = state.placesDetails;
                setState(() {});
              }
            },
            child: BlocBuilder<PlaceDetailsBloc, PlaceDetailsState>(
                builder: (context, state) {
              return TabBarView(
                children: [
                  ListView(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.33,
                        child: ListView.builder(
                          itemCount: placesDetails.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                top: screenHeight * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoute.aboutPlacesRoute,
                                    arguments: placesDetails[index],
                                  );
                                },
                                child: Container(
                                  width: screenWidth * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      screenWidth * 0.03,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: screenWidth * 0.8,
                                          height: screenHeight * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                placesDetails.isEmpty
                                                    ? "https://picknepal.com/wp-content/uploads/2020/06/Rara-Lake-1.jpg"
                                                    : placesDetails[index]
                                                        .placeImage!,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.01,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: screenWidth * 0.02,
                                            right: screenWidth * 0.02,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                placesDetails.isEmpty
                                                    ? ""
                                                    : placesDetails[index]
                                                        .placeTitle!,
                                                style: AppTextStyle
                                                    .poppinsSemiBold18,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color:
                                                        AppColors.ratingColors,
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.01,
                                                  ),
                                                  Text(
                                                    placesDetails.isEmpty
                                                        ? ""
                                                        : placesDetails[index]
                                                            .placeRating
                                                            .toString(),
                                                    style: AppTextStyle
                                                        .poppinsMedium18
                                                        .copyWith(
                                                      color: AppColors
                                                          .secondaryColors,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.01,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: screenWidth * 0.01,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 20,
                                                    color:
                                                        AppColors.ratingColors,
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.01,
                                                  ),
                                                  Text(
                                                    placesDetails.isEmpty
                                                        ? ""
                                                        : placesDetails[index]
                                                            .placeLocation!,
                                                    style: AppTextStyle
                                                        .poppinsMedium15
                                                        .copyWith(
                                                      color: AppColors
                                                          .secondaryColors,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.06,
                          top: screenHeight * 0.03,
                        ),
                        child: Text(
                          'Top Places',
                          style: AppTextStyle.poppinsMedium18.copyWith(
                            color: AppColors.secondaryColors,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.35,
                        child: ListView.builder(
                          itemCount: placesDetails.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                top: screenHeight * 0.02,
                                right: screenWidth * 0.05,
                              ),
                              child: Container(
                                height: screenHeight * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: screenWidth * 0.025,
                                        right: screenWidth * 0.01,
                                        top: screenHeight * 0.02,
                                        bottom: screenHeight * 0.02,
                                      ),
                                      child: Container(
                                        width: screenWidth * 0.2,
                                        height: screenHeight * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              placesDetails[index].placeImage!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          placesDetails.isEmpty
                                              ? ""
                                              : placesDetails[index]
                                                  .placeTitle!,
                                          style: AppTextStyle.poppinsMedium18
                                              .copyWith(
                                            color: AppColors.buttonNavBarColors,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.005,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: AppColors.ratingColors,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.01,
                                            ),
                                            Text(
                                              placesDetails.isEmpty
                                                  ? ""
                                                  : placesDetails[index]
                                                      .placeLocation!,
                                              style: AppTextStyle
                                                  .poppinsMedium15
                                                  .copyWith(
                                                fontSize: 12,
                                                color:
                                                    AppColors.secondaryColors,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.005,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: AppColors.ratingColors,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.01,
                                            ),
                                            Text(
                                              placesDetails.isEmpty
                                                  ? ""
                                                  : placesDetails[index]
                                                      .placeRating
                                                      .toString(),
                                              style: AppTextStyle
                                                  .poppinsMedium18
                                                  .copyWith(
                                                color:
                                                    AppColors.secondaryColors,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.06,
                          top: screenHeight * 0.03,
                        ),
                        child: Text(
                          'Popular Places',
                          style: AppTextStyle.poppinsMedium18.copyWith(
                            color: AppColors.secondaryColors,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.33,
                        child: ListView.builder(
                          itemCount: placesDetails.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                top: screenHeight * 0.02,
                              ),
                              child: Container(
                                width: screenWidth * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    screenWidth * 0.03,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.8,
                                        height: screenHeight * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              placesDetails[index].placeImage!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.02,
                                          right: screenWidth * 0.02,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              placesDetails.isEmpty
                                                  ? ""
                                                  : placesDetails[index]
                                                      .placeTitle!,
                                              style: AppTextStyle
                                                  .poppinsSemiBold18,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: AppColors.ratingColors,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.01,
                                                ),
                                                Text(
                                                  placesDetails.isEmpty
                                                      ? ""
                                                      : placesDetails[index]
                                                          .placeRating
                                                          .toString(),
                                                  style: AppTextStyle
                                                      .poppinsMedium18
                                                      .copyWith(
                                                    color: AppColors
                                                        .secondaryColors,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.01,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 20,
                                                  color:
                                                      AppColors.secondaryColors,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.01,
                                                ),
                                                Text(
                                                  placesDetails.isEmpty
                                                      ? ""
                                                      : placesDetails[index]
                                                          .placeLocation!,
                                                  style: AppTextStyle
                                                      .poppinsMedium15
                                                      .copyWith(
                                                    color: AppColors
                                                        .secondaryColors,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.06,
                          top: screenHeight * 0.03,
                        ),
                        child: Text(
                          'Nearby Places',
                          style: AppTextStyle.poppinsMedium18.copyWith(
                            color: AppColors.secondaryColors,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.33,
                        child: ListView.builder(
                          itemCount: placesDetails.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                top: screenHeight * 0.02,
                              ),
                              child: Container(
                                width: screenWidth * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    screenWidth * 0.03,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.8,
                                        height: screenHeight * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              placesDetails[index].placeImage!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.02,
                                          right: screenWidth * 0.02,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              placesDetails.isEmpty
                                                  ? ""
                                                  : placesDetails[index]
                                                      .placeTitle!,
                                              style: AppTextStyle
                                                  .poppinsSemiBold18,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: AppColors.ratingColors,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.01,
                                                ),
                                                Text(
                                                  placesDetails.isEmpty
                                                      ? ""
                                                      : placesDetails[index]
                                                          .placeRating
                                                          .toString(),
                                                  style: AppTextStyle
                                                      .poppinsMedium18
                                                      .copyWith(
                                                    color: AppColors
                                                        .secondaryColors,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.01,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 20,
                                                  color:
                                                      AppColors.secondaryColors,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.01,
                                                ),
                                                Text(
                                                  placesDetails.isEmpty
                                                      ? ""
                                                      : placesDetails[index]
                                                          .placeLocation!,
                                                  style: AppTextStyle
                                                      .poppinsMedium15
                                                      .copyWith(
                                                    color: AppColors
                                                        .secondaryColors,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.06,
                          top: screenHeight * 0.03,
                        ),
                        child: Text(
                          'Recommended Places',
                          style: AppTextStyle.poppinsMedium18.copyWith(
                            color: AppColors.secondaryColors,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.33,
                        child: ListView.builder(
                          itemCount: placesDetails.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                top: screenHeight * 0.02,
                              ),
                              child: Container(
                                width: screenWidth * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    screenWidth * 0.03,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.8,
                                        height: screenHeight * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              placesDetails[index].placeImage!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.02,
                                          right: screenWidth * 0.02,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              placesDetails.isEmpty
                                                  ? ""
                                                  : placesDetails[index]
                                                      .placeTitle!,
                                              style: AppTextStyle
                                                  .poppinsSemiBold18,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: AppColors.ratingColors,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.01,
                                                ),
                                                Text(
                                                  placesDetails.isEmpty
                                                      ? ""
                                                      : placesDetails[index]
                                                          .placeRating
                                                          .toString(),
                                                  style: AppTextStyle
                                                      .poppinsMedium18
                                                      .copyWith(
                                                    color: AppColors
                                                        .secondaryColors,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.01,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 20,
                                                  color:
                                                      AppColors.secondaryColors,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.01,
                                                ),
                                                Text(
                                                  placesDetails.isEmpty
                                                      ? ""
                                                      : placesDetails[index]
                                                          .placeLocation!,
                                                  style: AppTextStyle
                                                      .poppinsMedium15
                                                      .copyWith(
                                                    color: AppColors
                                                        .secondaryColors,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
