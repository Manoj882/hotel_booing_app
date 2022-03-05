import 'package:flutter/material.dart';
import '/utils/size_config.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  const LottieAnimation(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.height * 2.5,),
      child: Column(
        children: [
          Center(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(
            height: SizeConfig.height * 1.5,
          ),
          Center(
            child: Lottie.asset(
              "assets/animations/purple-hotel.json",
            ),
          ),
        ],
      ),
    );
  }
}
