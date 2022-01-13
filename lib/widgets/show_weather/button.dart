import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final Function onTap;
  const MyButton({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Material(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(5),
          shadowColor: Colors.black,
          child: SizedBox(
            height: 32,
            width: 32,
            child: Center(child: child),
          )),
    );
  }
}
