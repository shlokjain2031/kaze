import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/models/tasks.dart';
import 'package:kaze/services/tasks.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/dialogs.dart';
import 'package:kaze/utils/sizes.dart';

import 'home.dart';

class Tasks extends StatefulWidget {
  String time;
  ModeModel mode;

  Tasks({Key key, this.time, this.mode}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  Colours colours = Colours();
  Sizes sizes = Sizes();

  List<TasksModel> allTasks = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TasksService().getAllTasks(widget.mode.title),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          EasyLoading.dismiss();
          allTasks = snapshot.data;
          return Scaffold(
            backgroundColor: colours.white(),
            body: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Home();
                                  },
                                ),
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: colours.black(),
                              size: sizes.width(context, 34),
                            ),
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 6),
                                    child: Text(
                                      widget.time,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          fontFamily: 'ProductSans',
                                          color: colours.black()
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: sizes.width(context, 140),
                                  height: sizes.height(context, 20),
                                  color: colours.black(opacity: .65),
                                  margin: EdgeInsets.only(top: 16),
                                ),
                              )
                            ],
                          ),

                          GestureDetector(
                              onTap: () {
                                CustomDialogs().addTask(context, colours, sizes, "", widget.mode, widget.time);
                              },
                              child: Image(
                              image: AssetImage('assets/add_icon.png'),
                              fit: BoxFit.fill,
                              width: sizes.width(context, 44),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: sizes.height(context, 40)),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.mode.title + " mode's daily tasks",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: colours.black(),
                            fontFamily: 'ProductSans',
                            decoration: TextDecoration.underline,
                            letterSpacing: 3.5
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sizes.height(context, 48)),

                    SizedBox(
                      width: sizes.width(context, 358),
                      height: sizes.height(context, 680),
                      child: ListView.builder(
                        itemCount: allTasks.length ?? 0,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          TasksModel task = allTasks[index];
                          bool isTaskDone = task.isTaskDone.toLowerCase() == "true";
                          if(isTaskDone) {
                            return GestureDetector(
                              onTap: () {
                                TasksService().updateTask(task.title, widget.mode.title, !isTaskDone);
                                setState(() {});
                              },
                              child: Container(
                                height: sizes.height(context, 72),
                                margin: EdgeInsets.only(bottom: sizes.height(context, 32)),
                                decoration: BoxDecoration(
                                    color: colours.black(),
                                    border: Border.all(color: colours.black(), width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(8, 16),
                                          color: colours.black(opacity: .05),
                                          blurRadius: 32
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: sizes.width(context, 40),
                                        height: sizes.height(context, 40),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colours.white(),
                                        ),
                                        child: Icon(
                                          Icons.done_sharp,
                                          color: colours.black(),
                                          size: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        width: sizes.width(context, 240),
                                        child: Text(
                                          task.title,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            fontSize: 24,
                                            color: colours.white(),
                                            decoration: TextDecoration.lineThrough
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          TasksService().deleteTask(task.title, widget.mode.title);
                                          setState(() {});
                                        },
                                        child: Image(
                                          image: AssetImage('assets/delete.png'),
                                          fit: BoxFit.fill,
                                          width: sizes.width(context, 32),
                                          color: colours.white(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          else {
                            return GestureDetector(
                              onTap: () {
                                TasksService().updateTask(task.title, widget.mode.title, !isTaskDone);
                                setState(() {});
                              },
                              child: Container(
                                height: sizes.height(context, 72),
                                margin: EdgeInsets.only(bottom: sizes.height(context, 32)),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                    border: Border.all(color: colours.black(), width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(8, 16),
                                          color: colours.black(opacity: .05),
                                          blurRadius: 32
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: sizes.width(context, 40),
                                        height: sizes.height(context, 40),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(color: colours.black(), width: 2.5)
                                        ),
                                      ),
                                      SizedBox(
                                        width: sizes.width(context, 240),
                                        child: Text(
                                          task.title,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'ProductSans',
                                              fontSize: 24,
                                              color: colours.black(),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          TasksService().deleteTask(task.title, widget.mode.title);
                                          setState(() {});
                                        },
                                        child: Image(
                                          image: AssetImage('assets/delete_outline.png'),
                                          fit: BoxFit.fill,
                                          width: sizes.width(context, 32),
                                          color: colours.black(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
        else if(snapshot.data == null) {
          EasyLoading.dismiss();
          return Scaffold(
            backgroundColor: colours.black(),
            body: Column(
              children: [
                SizedBox(height: sizes.height(context, 200),),
                Text(
                  'No tasks in\n' + widget.mode.title + " mode",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                      color: colours.white(),
                      fontFamily: 'ProductSans'
                  ),
                ),
                SizedBox(height: sizes.height(context, 100),),
                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            CustomDialogs().addTask(context, colours, sizes, "title", widget.mode, widget.time);
                          },
                          child: Container(
                            width: sizes.width(context, 150),
                            height: sizes.height(context, 80),
                            padding: EdgeInsets.only(top: sizes.height(context, 24)),
                            decoration: BoxDecoration(
                                color: colours.white(),
                                border: Border.all(color: colours.black(), width: 2)
                            ),
                            child: Text(
                              'add a task',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: colours.black(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Home();
                                },
                              ),
                            );
                          },
                          child: Container(
                            width: sizes.width(context, 120),
                            height: sizes.height(context, 80),
                            padding: EdgeInsets.only(top: sizes.height(context, 24)),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: colours.white(), width: 2)
                            ),
                            child: Text(
                              'go back',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: colours.white(),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        else {
          EasyLoading.show(status: "loading");
          return SizedBox();
        }
      },
    );
  }
}
