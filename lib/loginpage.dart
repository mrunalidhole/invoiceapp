import 'package:flutter/material.dart';
import 'package:invoiceapp/itempage.dart';
import 'package:invoiceapp/loginprovider.dart';
import 'package:invoiceapp/main.dart';
import 'package:invoiceapp/registrationpage.dart';
import 'package:invoiceapp/registrationprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLogin = false;
  CheckLogin()async{
    SharedPreferences state = await SharedPreferences.getInstance();
    setState(() async{
      final phoneno = await state.getString('phoneno');
      if(phoneno != ''){
        isLogin = true;
      }
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckLogin();
  }

  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return ItemPage();
    } else {
      return Scaffold(
        backgroundColor: Color.fromRGBO(13, 3, 12, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(13, 3, 12, 1),
        ),
        body: Consumer<LoginProvider>(
          builder: (context, login, child) =>
              Stack(
                children: [
                  Image.asset('assets/background2.png'),
                Column(
                  children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 110, right: 30),
                     child: RichText(text: TextSpan(
                       children: [
                         TextSpan(text: 'Welcome\n', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
                         TextSpan(text: 'Back!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Color.fromRGBO(196, 81, 201, 10)))
                       ]
                     )),
                   ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: login.phoneno,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15))),
                            prefixIcon: Icon(Icons.phone,color: Colors.white,),
                            labelText: 'Phone No.', labelStyle: TextStyle(color: Colors.white),

                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: login.password,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15))),
                            prefixIcon: Icon(Icons.lock, color: Colors.white,),
                            labelText: 'Password', labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(colors: [Color.fromRGBO(169, 1, 109, 10), Color.fromRGBO(116, 1, 130, 10)])
                        ),
                        child: ElevatedButton(onPressed: () async {
                          bool nav = await login.LogData();
                          if(nav){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemPage()));
                          }
                          SharedPreferences state = await SharedPreferences
                              .getInstance();
                          await state.setString('phoneno', login.phoneno.text);
                          },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15))),
                                minimumSize: Size(double.infinity, 62)
                            ),
                            child: Text('LOG IN', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),)),
                      ),
                    ),
                    SizedBox(height: 25,),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: TextButton(onPressed: () {},
                              child: Text('Forgot Password?', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),)),
                        ),
                      ],
                    ),
                    SizedBox(height: 110,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?", style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                        },
                            child: Text('Sign up', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(196, 81, 201, 10)),))
                      ],
                    ),
                  ],
                ),
              ],

              ),
        ),
      );
    }
  }
}

