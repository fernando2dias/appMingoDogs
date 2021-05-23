import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mingo_app/src/screens/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email'
                    ),
                    onChanged: (value){
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
          ),
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password'
              ),
              onChanged: (value){
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) return Colors.orange;
                      return Colors.orangeAccent;
                    },
                  ),
                ),
                child: Text('SignIn'),
              onPressed: (){
                  auth.signInWithEmailAndPassword(email: _email, password: _password);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));


            }),
            ElevatedButton(child: Text('Signup'),
              onPressed: (){
                auth.createUserWithEmailAndPassword(email: _email, password: _password);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));

              } )

          ],)
        ],
      )

    );
  }
}
