import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailTextEditingController,
            ),
            TextFormField(
              controller: passwordTextEditingController,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                onPressed: (){
                  print(emailTextEditingController.text);
                  print(passwordTextEditingController.text);
                },
              child: Text("Submit"),
                )
          ],
        ),
      ),
    );
  }
}
