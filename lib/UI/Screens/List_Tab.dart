import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/utilties/AppColors.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedcalenderdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildcalendar(),
      Spacer(flex: 77,)
      ],
    );
  }

  buildcalendar() {
    return Expanded(flex: 23,
      child: Stack(
        children: [Column(children: [Expanded(child: Container(color: AppColors.secondryLight,)),Expanded(child: Container(color: AppColors.PrimaryLight,))],),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: selectedcalenderdate,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateChange: (selectedDate) {
              selectedcalenderdate = selectedDate;
              setState(() {});
            },timeLineProps: EasyTimeLineProps(separatorPadding: 19),
            dayProps: const EasyDayProps(
              todayStyle: DayStyle(decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.all(Radius.circular(24)))),
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.all(Radius.circular(24))),
              ),
              activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                      color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                  dayStrStyle: TextStyle(
                      color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                  monthStrStyle: TextStyle(
                      color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.all(Radius.circular(24)))),
            ),
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
