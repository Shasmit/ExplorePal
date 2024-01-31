import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:exploree_pal/config/constants/app_textstyle_theme.dart';
import 'package:exploree_pal/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';

class LoginViews extends ConsumerStatefulWidget {
  const LoginViews({super.key});

  @override
  ConsumerState<LoginViews> createState() => _LoginViewsState();
}

class _LoginViewsState extends ConsumerState<LoginViews> {
  bool _isObscure = true;
  final pinkey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    SizedBox gap() {
      return SizedBox(
        height: screenHeight * 0.025,
      );
    }

    Widget padds(
      String title,
      Color textcolor,
      TextStyle styles,
    ) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
        child: Text(
          title,
          style: styles,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bodyColors,
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        width: double.infinity,
        child: Form(
          key: pinkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                //   child: IconButton(
                //     icon: const Icon(Icons.arrow_back),
                //     iconSize: 28.0,
                //     onPressed: () {
                //       Navigator.pushNamed(context, AppRoute.introRoute);
                //     },
                //     alignment: Alignment.topLeft,
                //   ),
                // ),
                const AspectRatio(
                  aspectRatio: 12 / 5,
                  child: Image(
                    image: AssetImage('assets/images/explorepal.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                gap(),
                padds(
                  'Login',
                  AppColors.buttonNavBarColors,
                  AppTextStyle.poppinsSemiBold25,
                ),
                padds(
                  'Your Destination Is In Your Hands',
                  AppColors.secondaryColors,
                  AppTextStyle.poppins18,
                ),
                gap(),
                padds(
                  'Username',
                  AppColors.buttonNavBarColors,
                  AppTextStyle.poppinsMedium18,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: TextFormField(
                    key: const ValueKey('username'),
                    controller: username,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Poppins",
                    ),
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.buttonColors,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.secondaryColors),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.secondaryColors),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'Enter your username',
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Poppins",
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                gap(),
                padds(
                  'Password',
                  AppColors.buttonNavBarColors,
                  AppTextStyle.poppinsMedium18,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: TextFormField(
                    key: const ValueKey('password'),
                    obscureText: _isObscure,
                    controller: password,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (text.length < 8) {
                        return 'Password should be at least 8 characters long';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Poppins",
                    ),
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.buttonColors,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.secondaryColors),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.secondaryColors),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Poppins",
                      ),
                      suffixIcon: Align(
                        widthFactor: 1.5,
                        heightFactor: 1.0,
                        child: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (pinkey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .loginUser(
                                context,
                                username.text,
                                password.text,
                                // ref,
                              );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'LOGIN',
                          style: AppTextStyle.poppinsSemiBold20.copyWith(
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                gap(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                          // wordSpacing: 0.8,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoute.registerRoute);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'PoppinsMedium',
                            fontSize: 15.0,
                            letterSpacing: 0.9,
                            color: AppColors.buttonColors,
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
      ),
    );
  }
}
