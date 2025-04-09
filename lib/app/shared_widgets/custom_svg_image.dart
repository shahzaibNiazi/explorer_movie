import 'package:moview_explorer_app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSVGImage extends StatelessWidget {
  final String path;
  final Color? clr;
  const CustomSVGImage({super.key, required this.path, this.clr});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Utils.getSvgPath(path),
      fit: BoxFit.scaleDown,
      width: 40,
      height: 40,
      color: clr,
    );
  }
}
