import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_didinamarudin/configs/app_constants.dart';
import 'package:technical_test_didinamarudin/configs/enum_state.dart';
import 'package:technical_test_didinamarudin/data/network/api.dart';
import 'package:technical_test_didinamarudin/models/checklist_model.dart';
import 'package:technical_test_didinamarudin/moduls/checklistprovider.dart';
import 'package:technical_test_didinamarudin/screens/add_checklist_page.dart';
import 'package:technical_test_didinamarudin/screens/item_page.dart';
import 'package:technical_test_didinamarudin/screens/login_page.dart';
import 'package:technical_test_didinamarudin/utils/preference_helper.dart';
import 'package:technical_test_didinamarudin/widgets/item_cheklist.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
 void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CheckProvider>(context, listen: false).getChekList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CheckProvider>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await PreferenceHelper().deleteAll();
            Get.offAll(() => const LoginPage());
          },
          child: const Icon(
            Icons.logout_outlined,
            color: Colors.white,
            size: 25,
          ),
        ),
        appBar: AppBar(
          title: Text("Home"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => CreatPage());
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: provider.resultState == ResponseResult.hasData
            ? ListView.builder(
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  Datum data = provider.list[index];
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => ItemPAge(
                            itemId: data.id.toString(),
                            checkName: data.name ?? ""),
                      );
                    },
                    child: ItemChecklist(
                      text: data.name ?? "",
                      isDone: data.checklistCompletionStatus ?? false,
                      isLoading: false,
                      ontap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        Api().deleteChecklist(data.id).then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Success delete checklist"),
                              ),
                            );
                            provider.getChekList();
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Failed delete checklist"),
                              ),
                            );
                          }
                        });
                      },
                    ),
                  );
                })
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
