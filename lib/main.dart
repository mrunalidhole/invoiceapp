import 'package:flutter/material.dart';
import 'package:invoiceapp/itempage.dart';
import 'package:invoiceapp/itemprovider.dart';
import 'package:invoiceapp/loginpage.dart';
import 'package:invoiceapp/loginprovider.dart';
import 'package:invoiceapp/registrationprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()async{
  await Supabase.initialize(url: 'https://itsrlvjwkfmtlztvleys.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0c3Jsdmp3a2ZtdGx6dHZsZXlzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjcyNzQwMzIsImV4cCI6MjA0Mjg1MDAzMn0.eQAVK0btNw9c5MclArS_j_Nd5qp5OZdAw7IQqHpOVS8');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=>LoginProvider()),
      ChangeNotifierProvider(create: (context)=>RegistrationProvider()),
      ChangeNotifierProvider(create: (context)=>ItemProvider())],
      child: MaterialApp(
        home: InvoiceApp(),
      ),
    );
  }
}

class InvoiceApp extends StatefulWidget {
  const InvoiceApp({super.key});

  @override
  State<InvoiceApp> createState() => _InvoiceAppState();
}

class _InvoiceAppState extends State<InvoiceApp> {

  bool isLogin = false;
  CheckLogin()async{
    SharedPreferences state = await SharedPreferences.getInstance();
    setState(() async{
      final phoneno = await state.getString('phoneno');
      if(phoneno != ''){
        setState(() {
          isLogin = false;
        });
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
    if(isLogin) {
      return ItemPage();
    }else{
      return Scaffold(
        body: Consumer<LoginProvider>(
          builder: (context, login, child) =>
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(13, 3, 12, 1)
                    ),
                  ),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Image.asset('assets/background2.png'),
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/applogo.png', height: 220, width: 200,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ease\nBill', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),),
                      ],
                    ),
                  ),
                  Center(child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: "Let's Get\n", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60,
                                  color: Colors.white)),
                              TextSpan(text: "Started!", style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(196, 81, 201, 10)))
                            ]
                        ),
                      )
                  )
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 230, left: 70, right: 70),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(colors: [Color.fromRGBO(
                                169, 1, 109, 10), Color.fromRGBO(
                                116, 1, 130, 10)
                            ])
                        ),
                        child: ElevatedButton(
                            onPressed: () async {
                              bool nav = await login.LogData();
                              if (nav) {
                                if (login.phoneno.text != '' && login.password.text != '') {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPage()));
                                  SharedPreferences state = await SharedPreferences.getInstance();
                                  await state.setString('phoneno', login.phoneno.text);
                                }
                              }else{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                              }
                              },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                minimumSize: Size(double.infinity, 62)
                            ),
                            child: Text('LOG IN', style: TextStyle(color: Colors
                                .white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),)),
                      ),
                    ),
                  )
                ],
              ),
        ),
      );
    }
  }
}

