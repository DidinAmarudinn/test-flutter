import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technical_test_didinamarudin/configs/app_constants.dart';
import 'package:technical_test_didinamarudin/data/network/api.dart';
import 'package:technical_test_didinamarudin/screens/home_page.dart';
import 'package:technical_test_didinamarudin/screens/register_page.dart';
import 'package:technical_test_didinamarudin/widgets/button_loading.dart';
import 'package:technical_test_didinamarudin/widgets/button_widget.dart';
import 'package:technical_test_didinamarudin/widgets/gradient_text.dart';
import 'package:technical_test_didinamarudin/widgets/textfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController teEmail = TextEditingController();
  TextEditingController tePassword = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                "Sign In",
                gradient: gradientBlue,
                style: noColorTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: bold,
                ),
              ),
              SizedBox(
                height: defaultMargin / 4,
              ),
              Text(
                "Enter your Email and password to sign in",
                style: secondaryTextStyle.copyWith(fontWeight: reguler),
              ),
              SizedBox(
                height: defaultMargin * 2,
              ),
              TextFieldAuth(hint: "Username", controller: teEmail),
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
                            tePassword.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          Api()
                              .loginProccess(teEmail.text, tePassword.text)
                              .then((value) {
                            if (value != null) {
                              if (value) {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.off(() => const HomePage());
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
                    "Don’t have an account?",
                    style: secondaryTextStyle,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: ()  {
                      Get.to(()=>const SignUpPage());
                    },
                    child: GradientText(
                      "Sign Up",
                      gradient: gradientBlue,
                    ),
                  ),
                ],
              )
            ],
          )
        ]),
      )),
    );
  }
}
