import 'package:flutter/material.dart';
import 'package:invoiceapp/itempage.dart';
import 'package:invoiceapp/itemprovider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  DateTime _currentDate = DateTime.now();
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchDetail();
  }

  FetchDetail()async{
    SharedPreferences state = await SharedPreferences.getInstance();
    final phoneno = await state.getString('phoneno');
    final response = await Supabase.instance.client.from('registration').select().eq('phoneno', phoneno.toString());
    data =  List<Map<String, dynamic>>.from(response);
  }
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemPage()));
            },
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 25,),),
          ),
        ),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, item, child)=>Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only( top: 100),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 3, style: BorderStyle.solid)
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text('${data[0]['businessname']}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Date: ${DateFormat('dd/MM/yyyy').format(_currentDate)}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text('Time: ${DateFormat('hh:mm a').format(_currentDate)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Invoice NO.: ${data[0]['id']}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Billed To and Form
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Billed To:',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Text(item.billedToController.text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Text(item.phoneNoController.text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'From:',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                     Text('${data[0]['name']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                     Text('${data[0]['phoneno']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),

                            // Items Table
                            Container(
                              color: Colors.grey[400],
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(flex: 3, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                  Expanded(flex: 2, child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                  Expanded(flex: 2, child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                  Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: item.products.length,
                              itemBuilder: (context, index) {
                                final item1 = item.products[index];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(flex: 3, child: Text(item1['itemName'], style: TextStyle(fontSize: 16),)),
                                    Expanded(flex: 2, child: Text('${item1['quantity']}', style: TextStyle(fontSize: 16),)),
                                    Expanded(flex: 2, child: Text('${item1['price'].toStringAsFixed(2)}', style: TextStyle(fontSize: 16),)),
                                    Expanded(flex: 2, child: Text('${(item1['quantity'] * item1['price']).toStringAsFixed(2)}', style: TextStyle(fontSize: 16),),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Divider(thickness: 2),

                            // Total Amount
                            Column(mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('SubTotal:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(width: 11),
                                    Text('${item.getTotal().toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('Discount:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(width: 11),
                                    Text('${item.calculateDiscount().toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(width: 11),
                                    Text('${item.finalTotal().toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            //Payment info
                            Row(
                              children: [
                                Text('Payment Method:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                SizedBox(width: 5,),
                                Text(item.paymentMethodController.text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Note: Thank You for Choosing Us!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(colors: [Color.fromRGBO(169, 1, 109, 10), Color.fromRGBO(116, 1, 130, 10)])
                      ),
                      child: ElevatedButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                           minimumSize: Size(50, 62)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.download, color: Colors.white,),
                              Text('Download', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),),
                            ],
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(colors: [Color.fromRGBO(169, 1, 109, 10), Color.fromRGBO(116, 1, 130, 10)])
                      ),
                      child: ElevatedButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              minimumSize: Size(50, 62)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.share, color: Colors.white),
                              Text('Share', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
