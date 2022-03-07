import 'package:flutter/material.dart';

class GeneralDivider extends StatefulWidget {
  const GeneralDivider(this.dividerName,{ Key? key }) : super(key: key);

  final String dividerName;

  @override
  State<GeneralDivider> createState() => _GeneralDividerState();
}

class _GeneralDividerState extends State<GeneralDivider> {
  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 2,
                endIndent: 5,
                color: Color(0xffc8e6c9),
              ),
            ),
            Text(
              widget.dividerName,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                    color: Color(0xff81c784),
                  ),
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                indent: 5,
                color: Color(0xffc8e6c9),
              ),
            ),
          ],
        );
  }
}