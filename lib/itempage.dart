import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceapp/display.dart';
import 'package:invoiceapp/itemprovider.dart';
import 'package:invoiceapp/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 3, 12, 1),
      appBar: AppBar(
      backgroundColor: Color.fromRGBO(13, 3, 12, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(169, 1, 109, 10)
            ),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 25,),),
          ),
        ),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, item, child)=>SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'Item', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35)),
                    TextSpan(text: ' Details...', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromRGBO(196, 81, 201, 10)))
                  ]
                )),
                SizedBox(height: 30),
                // Add Item Section
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: item.itemNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      labelText: 'Item Name',labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: item.quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      labelText: 'Quantity', labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: item.priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      labelText: 'Price', labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        minimumSize: Size(double.infinity, 62)
                      ),
                      onPressed: item.addItem,
                      child: Text('Add Item', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'Customer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white)),
                    TextSpan(text: ' Details...',style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromRGBO(196, 81, 201, 10)) )
                  ]
                )),
                 SizedBox(height: 30,),
                // Billed To Section
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: item.billedToController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      labelText: 'Billed To', labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: item.phoneNoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      labelText: 'Phone No.', labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: item.paymentMethodController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      labelText: 'Payment Method', labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        minimumSize: Size(double.infinity, 62)
                      ),
                      onPressed: () async{
                        final response = await Supabase.instance.client.from('client').insert({
                          'name': item.billedToController.text,
                          'number': item.phoneNoController.text,
                          'payment': item.paymentMethodController.text
                        });
                        setState(() {});
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayPage()));
                        },
                      child: const Text('Generate Invoice', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
