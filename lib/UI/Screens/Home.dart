import 'package:flutter/material.dart';
import 'package:todo/UI/Screens/AddBottomSheet.dart';
import 'package:todo/UI/Screens/List_Tab.dart';
import 'package:todo/UI/Screens/Settings.dart';
import 'package:todo/utilties/AppColors.dart';
import 'package:todo/utilties/AppStyle.dart';
import 'package:todo/utilties/usermodel.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tabindex = 0;
  List<Widget> tabs = [];

  GlobalKey<ListTabState> liststate=GlobalKey();
@override
  void initState() {
  super.initState();
  tabs=[ListTab(key: liststate), Settings()];
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
            margin: EdgeInsets.fromLTRB(12, 25, 12, 12),
            child:
                Padding(padding: EdgeInsets.all(15), child: Text("Welcome Back, ${UserDM.currentUser?.name}")),
          ),
          titleTextStyle: AppStyle.AppBarStyle),
      bottomNavigationBar: BottomNavigationBarBuilder(),
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[tabindex],
    );
  }

  BottomNavigationBarBuilder() {
    return SizedBox(
      height: 70,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
            currentIndex: tabindex,
            onTap: (selectedindex) {
              tabindex = selectedindex;
              setState(() {});
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "list"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings")
            ]),
      ),
    );
  }

  buildFAB()  {
    return FloatingActionButton(
      elevation: 12,
      shape: StadiumBorder(
          side: BorderSide(
        color: Colors.white,
        width: 4,
      )),
      onPressed: () async{
        await AddBottomSheet.show(context);
        liststate.currentState?.LoadDataFromDatabase();

      },
      child: Icon(Icons.add),
      backgroundColor: AppColors.secondryLight,
    );
  }
}
