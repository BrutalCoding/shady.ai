import 'package:flutter/material.dart';

class HomeGridWidget extends StatelessWidget {
  const HomeGridWidget({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed != null
          ? Theme.of(context).colorScheme.surfaceVariant
          : Theme.of(context).disabledColor,
      type: MaterialType.card,
      textStyle: Theme.of(context).textTheme.titleLarge,
      child: InkWell(
        onTap: onPressed != null
            ? () {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sorry, this feature is not yet available.'),
                  ),
                );
              }
            : null,
        child: Center(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
