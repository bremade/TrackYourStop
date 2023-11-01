import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { info, success, error }

Color _getColor(ToastType type, BuildContext context) {
  switch (type) {
    case ToastType.info:
      return Theme.of(context).primaryColor;
    case ToastType.success:
      return const Color.fromARGB(255, 78, 140, 124);
    case ToastType.error:
      return const Color.fromARGB(255, 220, 48, 85);
  }
}

Icon _getIcon(ToastType type, BuildContext context) {
  switch (type) {
    case ToastType.info:
      return Icon(
        Icons.info_outline_rounded,
        color: Theme.of(context).primaryColor,
      );
    case ToastType.success:
      return const Icon(
        Icons.check_circle_rounded,
        color: Color.fromARGB(255, 78, 140, 124),
      );
    case ToastType.error:
      return const Icon(
        Icons.error_outline_rounded,
        color: Color.fromARGB(255, 240, 162, 156),
      );
  }
}

class CustomToast {
  static show({
    required BuildContext context,
    required String msg,
    ToastType toastType = ToastType.info,
    ToastGravity gravity = ToastGravity.TOP,
    int durationInSecond = 3,
  }) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final fToast = FToast();
    fToast.init(context);

    Widget toast = _buildToast(context, msg, toastType, isDarkTheme);

    fToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: Duration(seconds: durationInSecond),
    );
  }

  static Widget _buildToast(
      BuildContext context, String msg, ToastType toastType, bool isDarkTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: isDarkTheme ? Colors.grey[900] : Colors.grey[50],
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getIcon(toastType, context),
          const SizedBox(
            width: 12.0,
          ),
          Flexible(
            child: Text(
              msg,
              style: TextStyle(
                color: _getColor(toastType, context),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
