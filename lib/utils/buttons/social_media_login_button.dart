import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/constant.dart';
import '../../screens/home_screen.dart';
import '../size_config.dart';

class SocialMediaLogin extends StatefulWidget {
  const SocialMediaLogin(
    {
      required this.socialMediaName, 
      required this.onPressed, 
      required this.imageUrl,
      Key? key})
        : super(key: key);

  final String socialMediaName;
  final Function()? onPressed;
  final String imageUrl;

  @override
  State<SocialMediaLogin> createState() => _SocialMediaLoginState();
}

class _SocialMediaLoginState extends State<SocialMediaLogin> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.height * 2),
      ),
      onPressed: widget.onPressed,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              width: SizeConfig.width * 8,
              placeholder: (_, __) => SizedBox(
                width: SizeConfig.width * 8,
                height: SizeConfig.height * 4,
              ),
            ),
            SizedBox(
              width: SizeConfig.width * 3,
            ),
            Text(
              widget.socialMediaName,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
