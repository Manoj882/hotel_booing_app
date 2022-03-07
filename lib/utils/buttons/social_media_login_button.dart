import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';

class SocialMediaLoginButton extends StatefulWidget {
  const SocialMediaLoginButton(
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
  State<SocialMediaLoginButton> createState() => _SocialMediaLoginButtonState();
}

class _SocialMediaLoginButtonState extends State<SocialMediaLoginButton> {
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
