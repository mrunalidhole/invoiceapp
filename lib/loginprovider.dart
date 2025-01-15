import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginProvider extends ChangeNotifier{
   TextEditingController phoneno = TextEditingController();
   TextEditingController password = TextEditingController();

   List<Map<String, dynamic>> data = [];

   Future<bool> LogData() async {
      try {
         final response = await Supabase.instance.client
             .from('registration')
             .select()
             .eq('phoneno', phoneno.text)
             .eq('password', password.text);

         data = List<Map<String, dynamic>>.from(response);

         if (data.toString() == '[]') {
            return false;
         }
         return true;
      } catch (e) {
         // Handle the error, optionally log it or print for debugging
         print('Error in LogData: $e');
         return false;
      }
   }
}