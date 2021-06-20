import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template_package/error_state.dart';
import 'package:template_package/template_package.dart';

class ErrorFullScreenState extends AbstractErrorState {
  final Function() onCtaTap;

  ErrorFullScreenState({required Error error, required this.onCtaTap}) : super(error);

  @override
  void call(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: onCtaTap,
                child: Text(translate(context, "ok")),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(translate(context, 'something_went_wrong'))),
              ],
            ),
          );
        });
  }
}
