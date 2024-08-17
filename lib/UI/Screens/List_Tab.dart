import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo/UI/Screens/task.dart';
import 'package:todo/utilties/AppColors.dart';
import 'package:todo/utilties/dialogs.dart';
import 'package:todo/utilties/todoDM.dart';
import 'package:todo/utilties/usermodel.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => ListTabState();
}

class ListTabState extends State<ListTab> {
  List<TodoDM> TodosList = [];
  DateTime SelectedCalenderDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    LoadDataFromDatabase();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        buildcalendar(),
        Expanded(
          flex: 77,
          child: ListView.builder(
            itemCount: TodosList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (direction) {
                ShowErrorDialog(context,title: "The Task Is Deleted", ButtounTitle: "ok");
                  DeleteData(TodosList[index]);
                setState(() {
                  TodosList.removeAt(index); // Optionally remove the item from the list
                });
              },
                dragStartBehavior: DragStartBehavior.down,
                direction: DismissDirection.startToEnd,
                background: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: Colors.red),child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.delete,size: 50),
                  ],
                )),
                key: ValueKey<TodoDM>(TodosList[index]),
                child: ListTile(title: Task(item: TodosList[index]),
                ),
              );
            },),

        )
      ],
    );
  }

  buildcalendar() {
    return Expanded(
      flex: 23,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                    color: AppColors.secondryLight,
                  )),
              Expanded(
                  child: Container(
                    color: AppColors.PrimaryLight,
                  ))
            ],
          ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: SelectedCalenderDate,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateChange: (selectedDate) {
              setState(() {
                SelectedCalenderDate = selectedDate;
                 LoadDataFromDatabase();

              });
              },
            timeLineProps: EasyTimeLineProps(separatorPadding: 19),
            dayProps: const EasyDayProps(
              todayStyle: DayStyle(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24)))),
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
              ),
              activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  dayStrStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  monthStrStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24)))),
            ),
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void LoadDataFromDatabase() async {
    CollectionReference ref =
    FirebaseFirestore.instance.collection(UserDM.CollectionName).doc(UserDM.currentUser!.ID).collection(TodoDM.CollectionName);
    QuerySnapshot querySnapshot = await ref.get();
    List<QueryDocumentSnapshot> todos = querySnapshot.docs;

    TodosList = todos.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return TodoDM.fromjson(json);
    }).toList();
   TodosList= TodosList.where((todo) =>
    todo.date.year == SelectedCalenderDate.year &&
        todo.date.month == SelectedCalenderDate.month &&
        todo.date.day == SelectedCalenderDate.day).toList();
   setState(() {
   });
  }

  void DeleteData(TodoDM todo) {
    FirebaseFirestore.instance.collection(UserDM.CollectionName).doc(UserDM.currentUser!.ID).collection(TodoDM.CollectionName).doc(todo.id).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }
}
