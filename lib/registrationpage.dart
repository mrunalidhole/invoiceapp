import 'package:flutter/material.dart';
import 'package:invoiceapp/loginpage.dart';
import 'package:invoiceapp/registrationprovider.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 3, 12, 1),
      body: Consumer<RegistrationProvider>(
        builder: (context, register, child)=>Center(
          child: Stack(
            children: [
              Image.asset('assets/background2.png'),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 30),
                      child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: 'Create an\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.white)),
                          TextSpan(text: 'Account!', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Color.fromRGBO(196, 81, 201, 10)))
                        ]
                      )),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: register.businessname,
                        decoration: InputDecoration(
                          filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))),
                            labelText: 'Business Name', labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: register.name,
                        decoration: InputDecoration(
                          filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))),
                            labelText: 'Enter Your Name', labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: register.phoneno,
                        decoration: InputDecoration(
                          filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))),
                            labelText: 'Phone No.', labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: register.password,
                        decoration: InputDecoration(
                          filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))),
                            labelText: 'Password', labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: register.password2,
                        decoration: InputDecoration(
                          filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))),
                            labelText: 'Confirm Password', labelStyle: TextStyle(color: Colors.white)
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
                        child: ElevatedButton(onPressed: ()async{
                          if(register.password.text == register.password2.text){
                            bool nav = await register.AddData();
                            if(nav){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                            }
                          } else {
                            print("password and confirm password doesn't match");
                          }
                        },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                minimumSize: Size(double.infinity, 62)
                            ),
                            child: Text('REGISTER', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),)),
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?", style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                            child: Text('Sign In', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(196, 81, 201, 10)),))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
