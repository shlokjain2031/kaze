import 'package:flutter/material.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/models/tasks.dart';
import 'package:kaze/services/tasks.dart';
import 'package:kaze/utils/colours.dart';
import 'package:kaze/utils/loading.dart';
import 'package:kaze/utils/sizes.dart';

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
      future: TasksService().getAllTasks(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
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
                          Icon(
                            Icons.arrow_back,
                            color: colours.black(),
                            size: sizes.width(context, 34),
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    widget.time,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontFamily: 'ProductSans',
                                      color: colours.black()
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: sizes.width(context, 140),
                                height: sizes.height(context, 20),
                                color: colours.black(opacity: .65),
                              )
                            ],
                          ),

                          Image(
                            image: AssetImage('assets/add_icon.png'),
                            fit: BoxFit.fill,
                            width: sizes.width(context, 40),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: sizes.height(context, 40)),

                    Center(
                      child: Text(
                        widget.mode.title + "mode's daily tasks",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: colours.black(),
                          fontFamily: 'ProductSans',
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                    SizedBox(height: sizes.height(context, 32)),

                    SizedBox(
                      width: sizes.width(context, 358),
                      height: sizes.height(context, 680),
                      child: ListView.builder(
                        itemCount: allTasks.length,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          TasksModel task = allTasks[index];
                          if(task.isTaskDone.toLowerCase() == "true") {
                            return Container(
                              height: sizes.height(context, 72),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: sizes.width(context, 28),
                                    height: sizes.height(context, 28),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colours.white(),
                                    ),
                                    child: Icon(
                                      Icons.done_sharp,
                                      color: colours.black(),
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    task.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      fontSize: 24,
                                      color: colours.white(),
                                      decoration: TextDecoration.lineThrough
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage('assets/delete.png'),
                                    fit: BoxFit.fill,
                                    width: sizes.width(context, 28),
                                    color: colours.white(),
                                  )
                                ],
                              ),
                            );
                          }
                          else {
                            return Container(
                              height: sizes.height(context, 72),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: sizes.width(context, 28),
                                    height: sizes.height(context, 28),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: colours.black(), width: 2)
                                    ),
                                  ),
                                  Text(
                                    task.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        fontSize: 24,
                                        color: colours.black(),
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage('assets/delete_outline.png'),
                                    fit: BoxFit.fill,
                                    width: sizes.width(context, 28),
                                    color: colours.black(),
                                  )
                                ],
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
        else {
          return Loading();
        }
      },
    );
  }
}
