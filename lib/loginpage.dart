import 'package:flutter/material.dart';
import 'package:invoiceapp/itempage.dart';
import 'package:invoiceapp/loginprovider.dart';
import 'package:invoiceapp/registrationpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = false;
  CheckLogin() async {
    SharedPreferences state = await SharedPreferences.getInstance();
    setState(() async {
      final phoneno = await state.getString('phoneno');
      if (phoneno != '') {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    CheckLogin();
  }

  bool isPasswordVisible = false;
  bool showForgotPasswordOverlay = false;

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return ItemPage();
    } else {
      return Scaffold(
        backgroundColor: Color.fromRGBO(13, 3, 12, 1),
        body: Consumer<LoginProvider>(
          builder: (context, login, child) => Stack(
            children: [
              Center(
                child: Stack(
                  children: [
                    Image.asset('assets/background2.png'),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 110, right: 30),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Welcome\n',
                                      style: TextStyle(
                                          fontSize: 60,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  TextSpan(
                                      text: 'Back!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 60,
                                          color: Color.fromRGBO(196, 81, 201, 10)))
                                ])),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: login.phoneno,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white24,
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                labelText: 'Phone No.',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: login.password,
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white24,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible = !isPasswordVisible;
                                        });
                                      }),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  gradient: LinearGradient(colors: [Color.fromRGBO(169, 1, 109, 10), Color.fromRGBO(116, 1, 130, 10)])),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    bool nav = await login.LogData();
                                    if (nav) {
                                      if (login.phoneno.text != '' && login.password.text != '') {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPage()));
                                        SharedPreferences state = await SharedPreferences.getInstance();
                                        await state.setString('phoneno', login.phoneno.text);
                                      }
                                    }
                                    if (login.phoneno.text.isEmpty || login.password.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Phone No. and Paswword is Empty',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          backgroundColor: Colors.red[400],
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                                          action: SnackBarAction(
                                            label: 'DISMISS',
                                            textColor: Colors.white,
                                            onPressed: () {
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            },
                                          ),
                                          duration: Duration(minutes: 1),
                                        ),
                                      );
                                    }
                                    if (nav == false) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                          "Phone No. and Password Doesn't Matched",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        backgroundColor: Colors.red[400],
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                                        ),
                                        action: SnackBarAction(
                                          label: 'DISMISS',
                                          textColor: Colors.white,
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          },
                                        ),
                                        duration: Duration(minutes: 1),
                                      ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                      minimumSize: Size(double.infinity, 62)),
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        showForgotPasswordOverlay = true;
                                      });
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 110,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationPage()));
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        Color.fromRGBO(196, 81, 201, 10)),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Forgot Password Overlay
              if (showForgotPasswordOverlay)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: Card(
                        color: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.close, color: Colors.white,),
                                  onPressed: () {
                                    setState(() {
                                      showForgotPasswordOverlay = false;
                                    });
                                  },
                                ),
                              ),
                              Icon(Icons.error_outline, color: Color.fromRGBO(169, 1, 109, 10),
                              size: 50,),
                              SizedBox(height: 20,),
                              RichText(text: TextSpan(
                                children: [
                                  TextSpan(text: 'Forgot', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                                  TextSpan(text: ' Password', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromRGBO(196, 81, 201, 10)))
                                ]
                              )),
                              SizedBox(height: 20),
                              Text("Enter Your Phone No. and we'll send you a OTP on Registered\n                                              Phone No.", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white24,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    labelText: 'Enter Your Registred Phone No.',
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(15)),
                                    gradient: LinearGradient(colors: [Color.fromRGBO(169, 1, 109, 10), Color.fromRGBO(116, 1, 130, 10)])),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                    minimumSize: Size(30, 50)
                                  ),
                                    onPressed: () {},
                                    child: Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }
  }
}
