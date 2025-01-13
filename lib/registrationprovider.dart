import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrationProvider extends ChangeNotifier{
  TextEditingController businessname = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  String error = '';

  Future<bool>AddData()async{
    final response = await Supabase.instance.client.from('registration').insert({
      'businessname': businessname.text,
      'name': name.text,
      'phoneno': phoneno.text,
      'password': password.text,
    });
    return true;
  }
}