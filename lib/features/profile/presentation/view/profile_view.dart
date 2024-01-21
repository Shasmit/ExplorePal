import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_color_theme.dart';
import '../../../../config/constants/app_textstyle_theme.dart';
import '../../../home/presentation/widget/drawer.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Function to reload the data when the user triggers a refresh.
  Future<void> _handleRefresh() async {
    // Implement the logic to reload the data here.
    ref.watch(profileViewModelProvider.notifier).getUserProfile();
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(profileViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final profileState = ref.watch(profileViewModelProvider);

    if (profileState.isLoading) {
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
              color: AppColors.bodyColors,
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
                  "Profile",
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
                    'Your Profile',
                    style: AppTextStyle.poppinsBold25,
                  ),
                  Text(
                    'Profile Details',
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.05,
            right: screenWidth * 0.06,
          ),
          child: ListView(
            // physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: screenHeight * 0.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.grey[300],
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ref, ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _browseImage(ref, ImageSource.gallery);
                                    Navigator.pop(context);
                                    ref
                                        .watch(
                                            profileViewModelProvider.notifier)
                                        .getUserProfile();
                                  },
                                  icon: const Icon(Icons.image),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.buttonColors,
                            width: 1,
                          ),
                        ),
                        child: ClipOval(
                          child: _img != null
                              ? Image.file(
                                  _img!,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                )
                              : profileState.user[0].image != null
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
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          profileState.user[0].username,
                          style: AppTextStyle.poppinsMedium15,
                        ),
                        Text(
                          profileState.user[0].email,
                          style: AppTextStyle.poppinsMedium15
                              .copyWith(color: const Color(0xff6F7789)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
