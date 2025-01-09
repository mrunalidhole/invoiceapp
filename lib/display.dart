import 'package:flutter/material.dart';
import 'package:invoiceapp/itemprovider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  DateTime _currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 3, 12, 1),
      body: // Display Invoice
      Consumer<ItemProvider>(
        builder: (context, item, child)=>Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('${item.FetchDetail()}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
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
                            'Invoice NO. ${item.FetchDetail()}',
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
                               Text('${item.FetchDetail()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                               Text('${item.FetchDetail()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
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
                            Expanded(flex: 1, child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                            Expanded(flex: 1, child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                            Expanded(flex: 1, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
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
                              Expanded(flex: 1, child: Text('${item1['quantity']}', style: TextStyle(fontSize: 16),)),
                              Expanded(flex: 1, child: Text('${item1['price'].toStringAsFixed(2)}', style: TextStyle(fontSize: 16),)),
                              Expanded(flex: 1, child: Text('${(item1['quantity'] * item1['price']).toStringAsFixed(2)}', style: TextStyle(fontSize: 16),),
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
    );
  }
}
