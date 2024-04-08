import 'package:flutter/material.dart';

class RegistroFormProvider extends ChangeNotifier {
  // Clave global de acceso al formulario
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String confirmPassword = "";

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    // Si el formulario es válido devuelve true, en caso contrario false
    print('$email');
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}