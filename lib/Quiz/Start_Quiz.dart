import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../classes/classes.dart';
import 'question__model.dart';
import 'quiz__screen.dart';
import 'result_screen.dart';
import 'welcome_screen.dart';
import 'bindings_app.dart';

void main() {
  List<int> weakness_topics=[];
  runApp(Start_Quiz(100," ",weakness_topics));
}
class Start_Quiz extends StatelessWidget {
  final int id;
   String stat;
   List<int> weakness_topics;
  Start_Quiz(this.id,this.stat,this.weakness_topics);
  Map<int,int> student_answered={};
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(id,stat,weakness_topics),
      home:  WelcomeScreen(id,stat,weakness_topics),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen(id,stat,weakness_topics)),
        GetPage(name: QuizScreen.routeName, page: () =>  QuizScreen(id,stat,weakness_topics)),
        GetPage(name: ResultScreen.routeName, page: () =>  ResultScreen(id,student_answered)),
      ],
    );
  }
}
class AppColor {
  static final pripmaryColor = Color(0xFF252c4a);
  static final secondaryColor = Colors.blue;
}