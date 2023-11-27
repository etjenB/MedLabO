import 'package:flutter/material.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';

Future<bool> showConfirmationDialog(
    BuildContext context, String title, String content) async {
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.red)),
                      child: const Text(
                        'Ne',
                        style: TextStyle(color: primaryWhiteTextColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green)),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        'Da',
                        style: TextStyle(color: primaryWhiteTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ) ??
      false;
}

Future showErrorDialog(
    BuildContext context, String title, String content) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: const Text(
                    'Zatvori',
                    style: TextStyle(color: primaryWhiteTextColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
