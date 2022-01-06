import 'package:flutter/material.dart';
import 'package:technical_test_didinamarudin/configs/app_constants.dart';
import 'package:technical_test_didinamarudin/widgets/button_widget.dart';

class ItemChecklist extends StatelessWidget {
  final String text;
  final bool isLoading;
  final bool isDone;
  final VoidCallback ontap;
  final VoidCallback? ontapUpdate;
  final bool isItem;
  const ItemChecklist(
      {Key? key,
      required this.text,
      required this.isLoading,
      required this.ontap,
      required this.isDone,
      this.isItem = false,
      this.ontapUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultMargin),
      margin: EdgeInsets.symmetric(vertical: defaultMargin / 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: primaryTextStyle,
              ),
              Text(
                isDone ? 'done' : 'on progresss',
                style: isDone
                    ? greenTextStyle
                    : primaryTextStyle.copyWith(
                        color: Colors.red,
                      ),
              ),
              SizedBox(
                height: defaultMargin / 2,
              ),
              isItem
                  ? CustomButtonGradientWidget(
                      buttonName: isDone ? "Uncheck" : "Check is Done",
                      onPressed: ontapUpdate!,
                      height: 40,
                      width: 200,
                      color: gradientBlack,
                    )
                  : SizedBox()
            ],
          ),
          isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                )
              : IconButton(
                  onPressed: ontap,
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: blueColor,
                  ),
                ),
        ],
      ),
    );
  }
}
