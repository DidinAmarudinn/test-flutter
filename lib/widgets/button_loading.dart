import 'package:flutter/material.dart';
import 'package:technical_test_didinamarudin/configs/app_constants.dart';

class ButtonLoading extends StatelessWidget {
  final double height;
  final double width;
  final LinearGradient color;

  const ButtonLoading(
      {Key? key,
      required this.height,
      required this.width,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height/2,
            width:height/2,
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: defaultMargin / 3,
          ),
          Text(
            "Loading",
            style:
                whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          )
        ],
      ),
    );
  }
}
