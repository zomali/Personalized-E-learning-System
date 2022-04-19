import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'question__model.dart';
import 'bindings_app.dart';
import 'custom_button.dart';
import 'answer_option.dart';
import 'progress_timer.dart';
import 'question_card.dart';
import 'quiz__screen.dart';
import 'quiz_controller.dart';
import 'result_screen.dart';
import 'backButton.dart';

class QuizScreen extends StatelessWidget {
  late final String level;
  QuizScreen(this.level);
  static const routeName = '/quiz_screen';
  @override
  Widget build(BuildContext context) {
    String text;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white),
          ),
          SafeArea(
            child: GetBuilder<QuizController>(
              init: QuizController(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:Container(
                        child:Column(
                          children: [
                            Text(
                              " Quiz On Level "+level,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.blue),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: 'Question ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.blue),
                                      children: [
                                        TextSpan(
                                            text: controller.numberOfQuestion
                                                .round()
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(color: Colors.blue)),
                                        TextSpan(
                                            text: '/',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(color: Colors.blue)),
                                        TextSpan(
                                            text: controller.countOfQuestion.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(color: Colors.blue)),
                                      ]),
                                ),
                                ProgressTimer(),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 450,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => QuestionCard(
                        questionModel: controller.questionsList[index],
                      ),
                      controller: controller.pageController,
                      itemCount: controller.questionsList.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<QuizController>(
          init: QuizController(),
          builder: (controller) =>
              Row(
                children: [
                    SizedBox(width: 30,),
                  backButton(
                      onPressed: () =>
                          controller.previousQuestion(),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  nextButton(
                      onPressed: () => controller.nextQuestion()),
                ],
              )
      ),
    );
  }
}