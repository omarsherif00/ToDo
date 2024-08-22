import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ShowLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Row(children: [
            Text("loading..."),
            Spacer(),
            CircularProgressIndicator()
          ]),
        );
      });
}

HideLoading(BuildContext context) {
  Navigator.pop(context);
}

ShowErrorDialog(BuildContext context,
    {String? title, String? Body, String? ButtounTitle, Function? onclick}) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: Body != null ? Text(Body) : null,
      actions: [
        if(ButtounTitle!=null)
      TextButton(onPressed: () {
        HideLoading(context);
        onclick?.call();
      }, child: Text(ButtounTitle))
      ],
      );
    },
  );
}
