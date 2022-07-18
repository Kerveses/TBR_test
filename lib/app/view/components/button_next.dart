import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tbr_test/common/assets.dart';

class ButtonNext extends StatelessWidget {
  const ButtonNext({
    Key? key,
    this.active = false,
    this.onTap,
  }) : super(key: key);

  final bool active;
  final VoidCallback? onTap;

  static const double _size = 48.0;
  static final _borderRadius = BorderRadius.circular(16.0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: _borderRadius,
      onTap: active ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: active ? 1.0 : .4,
        child: Container(
          width: _size,
          height: _size,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: _borderRadius,
          ),
          child: Center(
            child: SvgPicture.asset(Assets.arrowRightIcon),
          ),
        ),
      ),
    );
  }
}
