import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siamtaskapp/models/user.dart';
import 'package:siamtaskapp/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    var url =
        Uri.parse('https://nodejs-task-manager-deploy.herokuapp.com/login');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      final userData = json.decode(response.body) as Map<String, dynamic>;
      var user = User(
          name: userData['name'],
          email: userData['email'],
          departments: userData['department'].cast<String>());
      //print(user.name + " " + user.email + " " + user.departments.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MenuDashboardPage(),
              settings: RouteSettings(arguments: user)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "User not found",
          textAlign: TextAlign.center,
        ),
      ));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text(
                    "Log In",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 163,
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
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Username",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Username or Email',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                            fontSize: 14,
                                          )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: _isObscure,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(_isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          }),
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                            fontSize: 14,
                                          )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ChechBox(),
                      Text(
                        "Forgot Password?",
                        style: GoogleFonts.roboto(
                          decoration: TextDecoration.underline,
                          color: Color(0xffFF6E30),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      login(usernameController.text.toString(),
                          passwordController.text.toString());
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
                                    "LOGIN",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChechBox extends StatefulWidget {
  const _ChechBox({Key? key}) : super(key: key);

  @override
  _ChechBoxState createState() => _ChechBoxState();
}

class _ChechBoxState extends State<_ChechBox> {
  bool rememberMe = false;
  void _onRememberMeChanged(bool? newValue) => setState(() {
        rememberMe = newValue!;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: rememberMe, onChanged: _onRememberMeChanged),
        Text(
          "Remember Me?",
          style: GoogleFonts.roboto(
            color: Color(0xff748FB5),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
