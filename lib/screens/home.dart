import 'package:carousel_slider/carousel_slider.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siamtaskapp/models/task.dart';
import 'package:siamtaskapp/models/user.dart';
import 'package:siamtaskapp/screens/auth.dart';
import 'package:siamtaskapp/screens/tasks.dart';
import 'package:siamtaskapp/themes/theme_file_for_dm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controllerForAnim;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  bool isDarkModeEnabled = false;
  late Size size = MediaQuery.of(context).size;
  late Animation<Offset> _slideAnimation;
  late int _currentPos = 0;
  late User user;
  late String dropdownValue;
  List<Task> allTaskLists = [];
  List<Task> inList = [];
  var _isinit = true;

  @override
  void initState() {
    super.initState();
    _controllerForAnim = AnimationController(vsync: this, duration: duration);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.8).animate(_controllerForAnim);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controllerForAnim);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controllerForAnim);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isinit) {
      user = ModalRoute.of(context)!.settings.arguments as User;
      dropdownValue = user.departments[0];
      getTasks(user.departments);
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  Future getTasks(List<String> departments) async {
    var url =
        Uri.parse('https://nodejs-task-manager-deploy.herokuapp.com/getTasks');
    for (String department in departments) {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'department': department,
          }));
      var taskData = json.decode(response.body) as List<dynamic>;
      for (var tasks in taskData) {
        var newTask = Task(
            title: tasks['title'],
            description: tasks['description'],
            department: tasks['department'],
            deadline: DateFormat('dd/MM/yyyy').parse(tasks['deadline']));
        allTaskLists.add(newTask);
      }
    }
    allTaskLists.sort((a, b) => a.deadline.compareTo(b.deadline));
    inList.add(allTaskLists[0]);
    inList.add(allTaskLists[1]);
    inList.add(allTaskLists[2]);
    // for (var individualTask in allTaskLists) {
    //   print(individualTask.deadline);
    // }
  }

  @override
  void dispose() {
    _controllerForAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.1, left: size.width * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.05, right: size.width * 0.1),
                      child: Text(
                        "Settings",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (isCollapsed) {
                            _controllerForAnim.forward();
                          } else {
                            _controllerForAnim.reverse();
                          }

                          isCollapsed = !isCollapsed;
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: Color(0xffFF6E30),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05, right: size.width * 0.5),
                  child: DayNightSwitcher(
                    isDarkModeEnabled: isDarkModeEnabled,
                    onStateChanged: (isDarkModeEnabled) {
                      setState(() {
                        this.isDarkModeEnabled = isDarkModeEnabled;
                        ThemeBuilder.of(context)?.changeTheme();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.05, right: size.width * 0.5),
                    child: Card(
                      child: Container(
                        color: Color(0xffFF6E30),
                        width: size.width * 0.3,
                        height: size.height * 0.05,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Log out",
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.exit_to_app_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    final CarouselController _mover = CarouselController();

    final List<Widget> imageSliders = inList
        .map((item) => Container(
              child: Container(
                width: size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Color(0xff748FB5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: Text(
                            "Task desription goes here in few lines..Task desription goes here in few lines..Task desription goes here in few lines..Task desription goes here in few lines..Task desription goes here in few lines..",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Color(0xff5E718C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Due by",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xffFF6E30),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        Jiffy(item.deadline).yMMMMd,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xffFF6E30),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              height: size.height,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.menu,
                          ),
                          onTap: () {
                            setState(() {
                              if (isCollapsed) {
                                _controllerForAnim.forward();
                              } else {
                                _controllerForAnim.reverse();
                              }

                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 101,
                      width: 101,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/ellipse.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("images/contact.png"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Welcome",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      user.name,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        color: Color(0xff748FB5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      user.email,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Color(0xff748FB5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              height: size.height * 0.07,
                              width: size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Color(0xffFAB35A),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Container(
                                height: size.height * 0.07,
                                width: size.width,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      isExpanded: true,
                                      icon: Transform.rotate(
                                          angle: 270 * 3.14 / 180,
                                          child: const Icon(
                                              Icons.arrow_back_ios,
                                              size: 15)),
                                      elevation: 16,
                                      style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                      underline: Container(
                                        height: 2,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      items: user.departments
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Upcoming Deadlines",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CarouselSlider(
                        items: imageSliders,
                        carouselController: _mover,
                        options: CarouselOptions(
                            autoPlay: true,
                            height: 200.0,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentPos = index;
                              });
                            }),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: inList.map((entry) {
                        int index = inList.indexOf(entry);
                        print(_currentPos);
                        return GestureDetector(
                          onTap: () => _mover.animateToPage(index),
                          child: Container(
                            width: 12.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Color(0xffFF6E30))
                                    .withOpacity(
                                        _currentPos == index ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskPage(),
                              settings: RouteSettings(
                                  arguments: allTaskLists
                                      .where((element) =>
                                          element.department == dropdownValue)
                                      .toList())),
                        );
                      },
                      child: Container(
                        height: 60,
                        child: Card(
                          color: Color(0xffFF6E30),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "VIEW ALL TASKS",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
