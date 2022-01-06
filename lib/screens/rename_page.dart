import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_didinamarudin/configs/app_constants.dart';
import 'package:technical_test_didinamarudin/data/network/api.dart';
import 'package:technical_test_didinamarudin/moduls/checklistprovider.dart';
import 'package:technical_test_didinamarudin/moduls/item_provider.dart';
import 'package:technical_test_didinamarudin/screens/home_page.dart';
import 'package:technical_test_didinamarudin/widgets/button_loading.dart';
import 'package:technical_test_didinamarudin/widgets/button_widget.dart';
import 'package:technical_test_didinamarudin/widgets/gradient_text.dart';
import 'package:technical_test_didinamarudin/widgets/textfield_widget.dart';

class RenamePage extends StatefulWidget {
  final String idCheck;
  final String itemName;
  final String idItem;
  const RenamePage(
      {Key? key,
      required this.idCheck,
      required this.idItem,
      required this.itemName})
      : super(key: key);

  @override
  _RenamePageState createState() => _RenamePageState();
}

class _RenamePageState extends State<RenamePage> {
 late TextEditingController renameC ;

  @override
  void initState() {
    super.initState();
    renameC = TextEditingController(text: widget.itemName);
  }
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                "Rename Item",
                gradient: gradientBlue,
                style: noColorTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: bold,
                ),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              TextFieldAuth(hint: widget.itemName, controller: renameC),
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
                        if (renameC.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          Api()
                              .rename(
                                  widget.idCheck, widget.idItem, renameC.text)
                              .then((value) {
                            if (value != null) {
                              if (value) {
                                provider.getItem(widget.idCheck);
                                setState(() {
                                  isLoading = false;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Success rename"),
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
                                  content: Text("Rename  Failed"),
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
