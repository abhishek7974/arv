import 'package:flutter/material.dart';

class Dialogs {

  static Future<void> errorDialog(BuildContext context, String err) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.error_outline,
            size: 45,
            color: Colors.redAccent,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                err,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: const Text(
                  'Back',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
  
  static Future<void> successDialog(BuildContext context, String message) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check_circle_outline,
            size: 45,
            color: Colors.greenAccent,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: const Text(
                  'Back',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

 

}
