import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  const LottieAnimation(this.title,{ Key? key }) : super(key: key);

  final String title;

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
              children: [
                Center(
                  child: Text(
                    widget.title,
                    style: headingStyle,
                  ),
                  
                ),
                const SizedBox(height: 10,),
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