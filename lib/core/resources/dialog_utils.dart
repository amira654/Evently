import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context,
      {String? message, bool dismissible = true}) {
    showDialog(
      barrierColor: Colors.black.withAlpha(200),
      barrierDismissible: dismissible,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: message == null
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              )
            : Row(
                children: [
                  Text(message),
                  const Spacer(),
                  const CircularProgressIndicator(),
                ],
              ),
      ),
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessageDialog(BuildContext context, String content,
      {String? posTitle,
      String? negTitle,
      VoidCallback? posAction,
      VoidCallback? negAction}) {
    List<Widget> actions = [];
    if (posTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posTitle)));
    }
    if (negTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negTitle)));
    }
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(content),
          actions: actions,
        );
      },
    );
  }
}
