import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_color_theme.dart';
import '../../../../config/constants/app_textstyle_theme.dart';
import '../../../home/presentation/widget/drawer.dart';
import '../viewmodel/watchlist_view_model.dart';

class WatchListView extends ConsumerStatefulWidget {
  const WatchListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatchListViewState();
}

class _WatchListViewState extends ConsumerState<WatchListView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Function to reload the data when the user triggers a refresh.
  Future<void> _handleRefresh() async {
    // Implement the logic to reload the data here.
    ref.watch(watchListViewModelProvider.notifier).getWatchList();
  }

  @override
  Widget build(BuildContext context) {
    final watchlistState = ref.watch(watchListViewModelProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (watchlistState.isLoading) {
      return Scaffold(
        body: Center(
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: const AlwaysStoppedAnimation(0.0),
                curve: Curves.linear,
              ),
            ),
            child: CircularProgressIndicator(
              color: AppColors.ratingColors,
              backgroundColor: AppColors.ratingColors,
            ),
          ),
        ),
      );
    }

    return Scaffold(
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
                  "Bookmarks",
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
                    'Your Bookmarked',
                    style: AppTextStyle.poppinsBold25,
                  ),
                  Text(
                    'Destinations',
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
      body: watchlistState.watchList!.isNotEmpty
          ? RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _handleRefresh,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.02,
                ),
                child: ListView(
                  children: [
                    GridView.builder(
                      itemCount: watchlistState.watchList!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              height: screenHeight * 0.125,
                              width: screenWidth * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    watchlistState
                                        .watchList![index].placeDetails.poster,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              watchlistState
                                  .watchList![index].placeDetails.title,
                              style: AppTextStyle.poppinsSemiBold15.copyWith(
                                color: AppColors.secondaryColors,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          : RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _handleRefresh,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      top: screenHeight * 0.02,
                    ),
                    child: Text(
                      'No destinations in your bookmarks yet!',
                      style: AppTextStyle.poppinsSemiBold20.copyWith(
                        color: AppColors.ratingColors,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
