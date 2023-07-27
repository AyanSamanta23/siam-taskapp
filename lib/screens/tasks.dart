import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siamtaskapp/models/task.dart';
import 'package:siamtaskapp/screens/loading.dart';
import 'package:siamtaskapp/screens/more_task.dart';
import '../addons/my_flutter_app_icons.dart';
import 'package:jiffy/jiffy.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool grid = false;
  List<Task> taskList = [];

  void viewMore(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => moretask(),
          settings: RouteSettings(arguments: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    taskList = ModalRoute.of(context)!.settings.arguments as List<Task>;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: queryData.size.height,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      taskList[0].department,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.dehaze))
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            grid = true;
                          });
                        },
                        icon: Icon(Icons.grid_view_sharp,
                            color: Color(0xFF748FB5))),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            grid = false;
                          });
                        },
                        icon: Icon(
                          Icons.sort,
                          color: Color(0xFF748FB5),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                (grid == true)
                    ? SingleChildScrollView(
                        child: Container(
                          height: queryData.size.height * 0.8,
                          child: new GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 30),
                              itemCount: taskList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  height: 100,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    elevation: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 35,
                                            width: 400,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0)),
                                                color: Color(0xFF5e718c)),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  Jiffy(taskList[index]
                                                          .deadline)
                                                      .yMMMMd,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                  ),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              taskList[index].title,
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                viewMore(taskList[index]);
                                              },
                                              child: Text(
                                                "view more",
                                                textAlign: TextAlign.justify,
                                                style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xFFFF6E30)),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    MyFlutterApp.pin,
                                                    color: Color(0xFF748FB5),
                                                    size: 28.0,
                                                  )),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    MyFlutterApp.bin,
                                                    color: Color(0xFF748FB5),
                                                    size: 28.0,
                                                  )),
                                              SizedBox(
                                                width: 30,
                                              ),
                                            ])
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          height: queryData.size.height * 0.8,
                          child: ListView.builder(
                              itemCount: taskList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: queryData.size.height * 0.23,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    elevation: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 35,
                                            width: 400,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0)),
                                                color: Color(0xFF5e718c)),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "Due by " +
                                                      Jiffy(taskList[index]
                                                              .deadline)
                                                          .yMMMMd,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                  ),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              taskList[index].title,
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                viewMore(taskList[index]);
                                              },
                                              child: Text(
                                                "view more",
                                                textAlign: TextAlign.justify,
                                                style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xFFFF6E30)),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    MyFlutterApp.thumbs_up,
                                                    color: Color(0xFF748FB5),
                                                    size: 28.0,
                                                  )),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    MyFlutterApp.vector__1_,
                                                    color: Color(0xFF748FB5),
                                                    size: 25.0,
                                                  )),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    MyFlutterApp.vector,
                                                    color: Color(0xFF748FB5),
                                                    size: 20.0,
                                                  )),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    MyFlutterApp.pin,
                                                    color: Color(0xFF748FB5),
                                                    size: 28.0,
                                                  )),
                                            ])
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
