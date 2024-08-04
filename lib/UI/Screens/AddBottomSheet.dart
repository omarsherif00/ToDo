import 'package:flutter/material.dart';
import 'package:todo/utilties/AppColors.dart';
import 'package:todo/utilties/AppStyle.dart';
import 'package:todo/utilties/DateExtenstion.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
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
  DateTime SelectedDate=DateTime.now();
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
            decoration: InputDecoration(
                hintText: "enter your task", hintStyle: AppStyle.HintTextStyle),
          ),
          SizedBox(
            height: 12,
          ),
          TextField(
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
          InkWell(onTap: (){
            ShowMyDatePicker();
          },
            child: Text(
              "${SelectedDate.FormatDate}",
              style: AppStyle.AppTextStyle,
            ),
          ),
          Spacer(),
          FloatingActionButton(
            onPressed: () {},
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
    SelectedDate=await showDatePicker(context: context,
        initialDate: SelectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)))?? SelectedDate;
    setState(() {

    });
  }
}
