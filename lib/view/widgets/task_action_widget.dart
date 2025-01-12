import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class actionbotton extends StatelessWidget {
  const actionbotton({super.key, required this.iconpath, this.onPressed});
  final String iconpath;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
          onPressed:onPressed,
          style: IconButton.styleFrom(
              padding: EdgeInsets.zero
          ),
          icon: SvgPicture.asset(iconpath,height: 21,width: 21)
      ),
    );
  }
}