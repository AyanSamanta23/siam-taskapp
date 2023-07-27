import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:siamtaskapp/addons/my_flutter_app_icons.dart';
import 'package:siamtaskapp/models/task.dart';

class moretask extends StatefulWidget {
  const moretask({Key? key}) : super(key: key);

  @override
  _moretaskState createState() => _moretaskState();
}

class _moretaskState extends State<moretask> {
  late final Task task;

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)!.settings.arguments as Task;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: queryData.size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 30),
          child: Center(
            child: Column(children: [
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
                    task.department,
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
              Container(
                height: queryData.size.height * 0.7,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 35,
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0)),
                              color: Color(0xFF5e718c)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Due by " + Jiffy(task.deadline).yMMMd,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            task.title,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.openSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 17,
                          ),
                          Text(
                            task.description,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
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
                        ],
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.45,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      MyFlutterApp.thumbs_up,
                                      color: Color(0xFF748FB5),
                                      size: 20.0,
                                    )),
                                Text(
                                  "15",
                                  style: TextStyle(
                                    color: Color(0xFF748FB5),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      MyFlutterApp.vector__1_,
                                      color: Color(0xFF748FB5),
                                      size: 20.0,
                                    )),
                                Text(
                                  "5",
                                  style: TextStyle(
                                    color: Color(0xFF748FB5),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      MyFlutterApp.vector,
                                      color: Color(0xFF748FB5),
                                      size: 20.0,
                                    )),
                                Text(
                                  "10",
                                  style: TextStyle(
                                    color: Color(0xFF748FB5),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ]),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Posted by: Admin name",
                style: TextStyle(color: Color(0xFF748FB5), fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Created on ",
                    style: TextStyle(
                      color: Color(0xFF748FB5),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "7th Jan 2022",
                    style: TextStyle(
                        color: Color(0xFF748FB5),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
