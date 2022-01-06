import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technical_test_didinamarudin/configs/app_constants.dart';
import 'package:technical_test_didinamarudin/data/network/api.dart';
import 'package:technical_test_didinamarudin/screens/login_page.dart';
import 'package:technical_test_didinamarudin/widgets/button_loading.dart';
import 'package:technical_test_didinamarudin/widgets/button_widget.dart';
import 'package:technical_test_didinamarudin/widgets/gradient_text.dart';
import 'package:technical_test_didinamarudin/widgets/textfield_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController teEmail = TextEditingController();
  TextEditingController tePassword = TextEditingController();
  TextEditingController teName = TextEditingController();
   bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    "Sign Up",
                    gradient: gradientBlack,
                    style: noColorTextStyle.copyWith(
                      fontSize: 32,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin / 4,
                  ),
                  Text(
                    "Use this forms to login or crate new account in your project for free",
                    style: secondaryTextStyle.copyWith(fontWeight: reguler),
                  ),
                  SizedBox(
                    height: defaultMargin * 2,
                  ),
                  TextFieldAuth(
                    hint: "Username",
                    controller: teName,
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  TextFieldAuth(
                    hint: "Email",
                    controller: teEmail
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  TextFieldAuth(
                    hint: "Password",
                    controller: tePassword,
                    isObcsure: true,
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                   isLoading
                  ? ButtonLoading(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: gradientBlue)
                  : CustomButtonGradientWidget(
                      buttonName: "Sign In",
                      onPressed: () async {
                        if (teEmail.text.isNotEmpty ||
                            tePassword.text.isNotEmpty || teName.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          Api()
                              .registerProcess(teEmail.text, tePassword.text,teName.text)
                              .then((value) {
                            if (value != null) {
                              if (value) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Register Success"),
                                  ),
                                );
                                Get.off(() => const LoginPage());
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Signin Failed"),
                                  ),
                                );
                              }
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("please fill all field"),
                            ),
                          );
                        }
                      },
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: gradientBlue),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: secondaryTextStyle,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Get.to(() => const LoginPage());
                        },
                        child: GradientText(
                          "Sign In",
                          gradient: gradientBlack,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
