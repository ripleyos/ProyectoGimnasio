import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  //Clave global de acceso al formulario
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  String email = "";
  String password = "";

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

 void updateEmail(String valor){
    email=valor;
    notifyListeners();
  }
  bool isValidForm(){

    //Si el formulario es válido devuelve true, en caso contrario false
    print('$email');
    print(formkey.currentState?.validate());
    return formkey.currentState?.validate() ?? false;

  }

}