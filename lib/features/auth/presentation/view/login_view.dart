import 'package:exploree_pal/config/constants/app_color_theme.dart';
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

  SizedBox gap() {
    return const SizedBox(
      height: 15.0,
    );
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget padds(
        String title,
        double fonts,
        double letters,
        Color textcolor,
        double left,
        double right,
        double top,
        double bottom,
        double wordSpace,
        FontWeight weight) {
      return Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fonts,
            fontWeight: weight,
            letterSpacing: letters,
            wordSpacing: wordSpace,
            color: textcolor,
          ),
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
                  aspectRatio: 12 / 3,
                  child: Image(
                    image: AssetImage('assets/images/filmcrate.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                gap(),
                padds('LOGIN', 35.0, 1.5, AppColors.buttonNavBarColors, 20, 0,
                    20, 0, 0, FontWeight.bold),
                padds(
                    'WELCOME TO THE WORLD OF MOVIES',
                    28.0,
                    0.2,
                    AppColors.secondaryColors,
                    20,
                    10,
                    0,
                    0,
                    0.5,
                    FontWeight.normal),
                gap(),
                padds('Username', 35.0, 1.0, Colors.black, 20, 10, 0, 0, 0,
                    FontWeight.w500),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    key: const ValueKey('username'),
                    controller: username,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
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
                      contentPadding: const EdgeInsets.all(20),
                      hintText: 'Enter your username',
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                gap(),
                padds('Password', 35.0, 1.0, Colors.black, 20, 10, 0, 0, 0,
                    FontWeight.w500),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                      contentPadding: const EdgeInsets.all(20),
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
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
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                //   child: Align(
                //     alignment: Alignment.bottomRight,
                //     child: TextButton(
                //       onPressed: () {
                //         Navigator.pushNamed(context, AppRoute.updatePassword);
                //       },
                //       child: const Text(
                //         'Forgot Password?',
                //         style: TextStyle(
                //           fontFamily: 'Dongle',
                //           fontSize: 28.0,
                //           letterSpacing: 0.2,
                //           color: AppColors.buttonNavBarColors,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // gap(),
                const SizedBox(
                  height: 45,
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
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontFamily: 'Dongle',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            fontSize: 35.0,
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
                          fontFamily: 'Dongle',
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
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
                            fontFamily: 'Dongle',
                            fontSize: 28.0,
                            fontWeight: FontWeight.w500,
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
