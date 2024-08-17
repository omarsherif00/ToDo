import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/utilties/AppColors.dart';
import 'package:todo/utilties/AppStyle.dart';
import 'package:todo/utilties/DateExtenstion.dart';
import 'package:todo/utilties/todoDM.dart';
import 'package:todo/utilties/usermodel.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static Future show(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddBottomSheet());
        });
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime SelectedDate = DateTime.now();
  TextEditingController TitleController = TextEditingController();
  TextEditingController DescreptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text("Add New Task",
              style:
                  AppStyle.AppTextStyle.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 12,
          ),
          TextField(
            controller: TitleController,
            decoration: InputDecoration(
                hintText: "enter your task", hintStyle: AppStyle.HintTextStyle),
          ),
          SizedBox(
            height: 12,
          ),
          TextField(
            controller: DescreptionController,
            decoration: InputDecoration(
                hintText: "enter your task descreption",
                hintStyle: AppStyle.HintTextStyle),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                "Select Time",
                style:
                    AppStyle.AppTextStyle.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              ShowMyDatePicker();
            },
            child: Text(
              "${SelectedDate.FormatDate}",
              style: AppStyle.AppTextStyle,
            ),
          ),
          Spacer(),
          FloatingActionButton(
            onPressed: () {
              BuildDatabase();
            },
            child: Icon(Icons.check),
            shape:
                StadiumBorder(side: BorderSide(width: 4, color: Colors.white)),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  void ShowMyDatePicker() async {
    SelectedDate = await showDatePicker(
            context: context,
            initialDate: SelectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        SelectedDate;
    setState(() {});
  }

  void BuildDatabase() {
    CollectionReference todosCollection = FirebaseFirestore.instance
        .collection(UserDM.CollectionName)
        .doc(UserDM.currentUser!.ID)
        .collection(TodoDM.CollectionName);
    DocumentReference doc = todosCollection.doc();
    TodoDM tododm = TodoDM(
        title: TitleController.text,
        date: SelectedDate,
        descreption: DescreptionController.text,
        id: doc.id,
        ischecked: false);
    doc.set(tododm.Tojson()).then((value) => Navigator.pop(context));
  }
}
