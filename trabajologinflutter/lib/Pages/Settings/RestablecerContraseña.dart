import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key }) : super(key: key);
  @override
  State<ChangePasswordPage>createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _emailController= TextEditingController();
@override
void dispose(){
  _emailController.dispose();
  super.dispose();
}

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

Future passwordReset() async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
}



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mete tu correo pa k tengas tu contra",
            textAlign: TextAlign.center
            ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Email',
                  fillColor: Colors.grey,
                  filled: true,
                ),
                ),
              ),
              MaterialButton(
                onPressed: passwordReset,
                child: Text('Reseteo contra'),
                color:  Colors.deepPurple,
              ),
          ],
        )
    );
  }

}
