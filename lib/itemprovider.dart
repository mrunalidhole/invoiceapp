import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier{
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
    if (total > 2000 && total <= 5000) {
      return total * 0.1;
    } else if (total > 5000 && total <= 10000) {
      return total * 0.2;
    }else if (total > 11000){
      return total * 0.3;
    }
    return 0.0;
  }
  
  finalTotal(){
    return getTotal() - calculateDiscount();
  }
}