import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryFlagWidget extends StatelessWidget {
  const CountryFlagWidget(this.flagSvg, {Key? key}) : super(key: key);

  final String flagSvg;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: SizedBox(
        width: 24,
        height: 20,
        child: SvgPicture.network(
          flagSvg,
          fit: BoxFit.fill,
          placeholderBuilder: (context) => Container(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
