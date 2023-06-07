import '../../core/init/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../core/init/constants/theme.dart';

class BottomMenuTextButton extends StatelessWidget {
  const BottomMenuTextButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Paddings.defaultTextButtonPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: UIColors.whiteColor,
            ),
      ),
    );
  }
}
