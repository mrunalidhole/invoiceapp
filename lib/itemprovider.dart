import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemProvider extends ChangeNotifier{


  // Controllers for text fields
  final itemNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final billedToController = TextEditingController();
  final phoneNoController = TextEditingController();
  final paymentMethodController = TextEditingController();
  final billedNumberController = TextEditingController();


  List<Map<String, dynamic>> products = [];
  void addItem() {
    products.add({
        'itemName': itemNameController.text,
        'quantity': int.parse(quantityController.text),
        'price': double.parse(priceController.text),
      });
      itemNameController.clear();
      quantityController.clear();
      priceController.clear();

  }

  double getTotal() {
    return products.fold(
        0, (sum, item) => sum + (item['quantity'] * item['price']));
  }

  double calculateDiscount() {
    double total = getTotal();
    if (total > 1000 && total <= 2500) {
      return total * 0.1;
    } else if (total > 2500 && total <= 5000) {
      return total * 0.2;
    }else if (total > 5000){
      return total * 0.3;
    }
    return 0.0;
  }
  
  finalTotal(){
    return getTotal() - calculateDiscount();
  }

  FetchDetail()async{
    final response = await Supabase.instance.client.from('registration').update({});
    return List<Map<String, dynamic>>.from(response);

  }
}