import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:exploree_pal/config/constants/app_textstyle_theme.dart';
import 'package:exploree_pal/config/router/app_route.dart';
import 'package:exploree_pal/features/auth/domain/entity/user_entity.dart';
import 'package:exploree_pal/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterViews extends ConsumerStatefulWidget {
  const RegisterViews({super.key});

  @override
  ConsumerState<RegisterViews> createState() => _RegisterViewsState();
}

class _RegisterViewsState extends ConsumerState<RegisterViews> {
  bool _isObscure = true;
  bool _isObscure1 = true;
  final registerkey = GlobalKey<FormState>();

  SizedBox gap() {
    return const SizedBox(
      height: 5.0,
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authViewModelProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    SizedBox gapa() {
      return SizedBox(
        height: screenHeight * 0.02,
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: double.infinity,
        child: Form(
          key: registerkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 25.0,
                    color: AppColors.buttonColors,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.loginRoute);
                    },
                    alignment: Alignment.topLeft,
                  ),
                ),
                AspectRatio(
                  aspectRatio: screenHeight * 0.015 / 3,
                  child: const Image(
                    image: AssetImage('assets/images/explorepal.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                padds(
                  'Register',
                  AppColors.buttonNavBarColors,
                  AppTextStyle.poppinsSemiBold25,
                ),
                padds(
                  'Join Us On the Journey',
                  AppColors.secondaryColors,
                  AppTextStyle.poppins18,
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                padds(
                  'Username',
                  AppColors.buttonNavBarColors,
                  AppTextStyle.poppinsMedium18,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: TextFormField(
                    controller: username,
                    validator: (text) {
                      if (text == null) {
                        return 'Please enter username';
                      }
                      if (text.isEmpty) {
                        return 'Enter an username';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Poppins",
                    ),
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
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
                        fontFamily: 'Poppins',
                      ),
                    ),
                    cursorColor: AppColors.buttonNavBarColors,
                  ),
                ),
                gap(),
                padds(
                  'Email',
                  AppColors.buttonNavBarColors,
                  AppTextStyle.poppinsMedium18,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: TextFormField(
                    controller: email,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter an email';
                      }
                      const emailPattern =
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                      if (!RegExp(emailPattern).hasMatch(text)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Poppins",
                    ),
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
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
                      hintText: 'Enter your email',
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Poppins",
                      ),
                    ),
                    cursorColor: AppColors.buttonNavBarColors,
                  ),
                ),
                gap(),
                padds(
                  'Password',
                  AppColors.buttonNavBarColors,
                  AppTextStyle.poppinsMedium18,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: TextFormField(
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
                        borderSide: const BorderSide(
                          color: Colors.red,
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
                    cursorColor: AppColors.buttonNavBarColors,
                  ),
                ),
                gap(),
                padds(
                  'Confirm Password',
                  AppColors.buttonNavBarColors,
                  AppTextStyle.poppinsMedium18,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: TextFormField(
                    obscureText: _isObscure1,
                    controller: confirmpass,
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
                        borderSide: const BorderSide(
                          color: Colors.red,
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
                              _isObscure1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
                              });
                            }),
                      ),
                    ),
                    cursorColor: AppColors.buttonNavBarColors,
                  ),
                ),
                gapa(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (registerkey.currentState!.validate()) {
                          var user = UserEntity(
                            username: username.text,
                            email: email.text,
                            password: password.text,
                            confirmPassword: confirmpass.text,
                          );
                          ref
                              .read(authViewModelProvider.notifier)
                              .registerUser(context, user);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'REGISTER',
                          style: AppTextStyle.poppinsSemiBold20.copyWith(
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
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
