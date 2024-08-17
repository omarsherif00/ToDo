import 'package:flutter/material.dart';
import 'package:todo/utilties/AppColors.dart';
import 'package:todo/utilties/AppStyle.dart';
import 'package:todo/utilties/todoDM.dart';

class Task extends StatefulWidget {
  TodoDM item;


  Task({super.key, required this.item});

  @override
  State<Task> createState() => _TaskState();
}
 bool isDone=false;
class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.symmetric(horizontal: 26, vertical: 22),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      child: Row(children: [
        VerticalLine(context),
        SizedBox(
          width: 25,
        ),
        TaskDetailsColumn(),
        Spacer(flex: 10),
        CheckboxButton(),
      ]),
    );
  }

  TaskDetailsColumn() {
    return Expanded(flex:90 ,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.item.title,
          style: AppStyle.TaskStyle,

        ),SizedBox(height: 7,),
        Text(
          widget.item.descreption,
          style: AppStyle.TasksmallStyle,

        )
      ]),
    );
  }

  CheckboxButton() {
    return InkWell(
      onTap: (){
        setState(() {
          isDone=!isDone;
        });
        },
      child: Container(
        child: Icon(Icons.check, size: 40,color: Colors.white),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.secondryLight,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
      ),
    );
  }

  VerticalLine(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .07,
      width: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondryLight,
      ),
    );
  }

}
