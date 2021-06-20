import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/views/home_view.dart';

class TodoProvider extends ChangeNotifier {
  final httpClient = http.Client();
  List<dynamic>? todoData;
  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8",
  };

  //GET Request
  Future fetchData() async {
    final Uri restAPIURL = Uri.parse("https://todo-mefn.herokuapp.com/");

    http.Response response = await httpClient.get(restAPIURL);

    final Map parsedData = await json.decode(response.body.toString());

    todoData = parsedData['data'];
  }

  //Post Request
  Future addData(Map<String, String> body, BuildContext context) async {
    final Uri restAPIURL = Uri.parse("https://todo-mefn.herokuapp.com/add");
    try {
      http.Response response = await httpClient
          .post(
        restAPIURL,
        headers: customHeaders,
        body: jsonEncode(body),
      )
          .whenComplete(
        () {
          Navigator.pop(context);
          customToastWidget(
            "Data Saved!",
            context,
            Icons.task_alt_outlined,
          );
          Navigator.pushReplacement(context,
              PageTransition(child: HomeView(), type: PageTransitionType.fade));
        },
      );
      return response.body;
    } catch (e) {
      Navigator.pop(context);
      customToastWidget(
        "Failed!",
        context,
        Icons.error_outline,
      );
    }
  }

  //DELETE Request
  Future deleteData(BuildContext context, String id) async {
    final Uri restAPIURL = Uri.parse("https://todo-mefn.herokuapp.com/delete");
    try {
      http.Response response = await httpClient
          .delete(restAPIURL,
              headers: customHeaders, body: jsonEncode({"id": id}))
          .whenComplete(
        () {
          customToastWidget(
            "Data Deleted!",
            context,
            Icons.task_alt_outlined,
          );
          Navigator.pushReplacement(context,
              PageTransition(child: HomeView(), type: PageTransitionType.fade));
        },
      );

      return response.body;
    } catch (e) {
      Navigator.pop(context);
      customToastWidget(
        "Failed!",
        context,
        Icons.error_outline,
      );
    }
  }

  //UPDATE Request(PUT)
  Future updateData(Map<String, String> data, BuildContext context) async {
    final Uri restAPIURL = Uri.parse("https://todo-mefn.herokuapp.com/update");
    try {
      http.Response response = await httpClient
          .put(restAPIURL, headers: customHeaders, body: jsonEncode(data))
          .whenComplete(
        () {
          Navigator.pop(context);
          customToastWidget(
            "Data Updated!",
            context,
            Icons.task_alt_outlined,
          );
          Navigator.pushReplacement(context,
              PageTransition(child: HomeView(), type: PageTransitionType.fade));
        },
      );

      return response.body;
    } catch (e) {
      Navigator.pop(context);
      customToastWidget(
        "Failed!",
        context,
        Icons.error_outline,
      );
    }
  }

  customToastWidget(String msg, BuildContext context, IconData icon) {
    return showToastWidget(
        Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.black38,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.tealAccent[400],
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                msg,
                style: TextStyle(color: Colors.tealAccent[400], fontSize: 20.0),
              )
            ],
          ),
        ),
        context: context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        duration: Duration(seconds: 4),
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }
}
