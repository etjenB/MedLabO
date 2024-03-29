import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void makeErrorToast(String message) {
  showToastWidget(
      Container(
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
            text: TextSpan(
              text: message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      position: const ToastPosition(align: Alignment.bottomCenter));
}

void makeSuccessToast(String message) {
  showToastWidget(
    Container(
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RichText(
          text: TextSpan(
            text: message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
  );
}

void makeAlertToast(String message, String status,
    [AlignmentGeometry toastPosition = Alignment.bottomCenter]) {
  Color? toastColor;
  switch (status) {
    case "error":
      toastColor = Colors.red[400];
      break;
    case "success":
      toastColor = Colors.green[400];
      break;
    case "warning":
      toastColor = Colors.yellow[600];
      break;
    default:
      toastColor = Colors.grey[400];
      break;
  }
  showToastWidget(
    Container(
      decoration: BoxDecoration(
        color: toastColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RichText(
          text: TextSpan(
            text: message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
    position: ToastPosition(align: toastPosition),
  );
}
