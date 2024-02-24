import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  final String title, buttonTitle;
  final void Function()? onPressed;
  final Color? textColor;
  final bool showActionButton;
  const TSectionHeading({
    super.key,
    required this.title,
    this.buttonTitle = "View all",
    this.onPressed,
    this.textColor,
    this.showActionButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle)),
      ],
    );
  }
}