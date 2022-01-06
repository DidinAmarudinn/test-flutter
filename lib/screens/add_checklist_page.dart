import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_didinamarudin/configs/app_constants.dart';
import 'package:technical_test_didinamarudin/data/network/api.dart';
import 'package:technical_test_didinamarudin/moduls/checklistprovider.dart';
import 'package:technical_test_didinamarudin/screens/home_page.dart';
import 'package:technical_test_didinamarudin/screens/register_page.dart';
import 'package:technical_test_didinamarudin/widgets/button_loading.dart';
import 'package:technical_test_didinamarudin/widgets/button_widget.dart';
import 'package:technical_test_didinamarudin/widgets/gradient_text.dart';
import 'package:technical_test_didinamarudin/widgets/textfield_widget.dart';

class CreatPage extends StatefulWidget {
  const CreatPage({Key? key}) : super(key: key);

  @override
  _CreatPageState createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  TextEditingController teCheklist = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<CheckProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                "Create Checklist",
                gradient: gradientBlue,
                style: noColorTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: bold,
                ),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              TextFieldAuth(hint: "Checklist Name", controller: teCheklist),
              SizedBox(
                height: defaultMargin,
              ),
              isLoading
                  ? ButtonLoading(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: gradientBlue)
                  : CustomButtonGradientWidget(
                      buttonName: "Create",
                      onPressed: () async {
                        if (teCheklist.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          Api().addCheckList(teCheklist.text).then((value) {
                            if (value != null) {
                              if (value) {
                                provider.getChekList();
                                setState(() {
                                  isLoading = false;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Success"),
                                  ),
                                );
                              }
                              Get.off(() => const HomePage());
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Create Checklist Failed"),
                                ),
                              );
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
            ],
          )
        ]),
      )),
    );
  }
}
