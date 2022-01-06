import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_didinamarudin/configs/enum_state.dart';
import 'package:technical_test_didinamarudin/data/network/api.dart';
import 'package:technical_test_didinamarudin/models/item_model.dart';
import 'package:technical_test_didinamarudin/moduls/checklistprovider.dart';
import 'package:technical_test_didinamarudin/moduls/item_provider.dart';
import 'package:technical_test_didinamarudin/screens/create_item_page.dart';
import 'package:technical_test_didinamarudin/screens/rename_page.dart';
import 'package:technical_test_didinamarudin/widgets/item_cheklist.dart';

class ItemPAge extends StatefulWidget {
  final String itemId;
  final String checkName;
  const ItemPAge({Key? key, required this.itemId, required this.checkName})
      : super(key: key);

  @override
  _ItemPAgeState createState() => _ItemPAgeState();
}

class _ItemPAgeState extends State<ItemPAge> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ItemProvider>(context, listen: false).getItem(widget.itemId);
    });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context);
    final checkprovider = Provider.of<CheckProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.checkName),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => CreatItemPage(
                      idCheck: widget.itemId,
                    ));
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: provider.resultState == ResponseResult.hasData
            ? ListView.builder(
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  DataItem data = provider.list[index];
                  return GestureDetector(
                    onTap: (){
                      Get.to(()=> RenamePage(idCheck: widget.itemId, idItem: data.id.toString(), itemName: data.name??""));
                    },
                    child: ItemChecklist(
                      text: data.name ?? "",
                      isItem: true,
                      isDone: data.itemCompletionStatus ?? false,
                      isLoading: false,
                      ontapUpdate: () {
                        setState(() {
                          isLoading = true;
                        });
                        Api()
                            .updateCheck(widget.itemId, data.id.toString())
                            .then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Success Update checklist"),
                              ),
                            );
                            
                            provider.getItem(widget.itemId);
                  
                            checkprovider.getChekList();
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
                      ontap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        Api()
                            .deleteItem(widget.itemId, data.id.toString())
                            .then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Success delete checklist"),
                              ),
                            );
                            provider.getItem(widget.itemId);
                  
                            checkprovider.getChekList();
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
