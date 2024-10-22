import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/screens/email_auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('login'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Email Address" 
                    ),
                  ),

                  const SizedBox(height: 10,),
                
                 const TextField(
                    decoration: InputDecoration(
                      labelText: "password" 
                    ),
                  ),

                   const SizedBox(height: 10,),

                  CupertinoButton(
                    onPressed: (){},
                    color: Colors.blue,
                    child: const Text("log In"),
                  ),

                  const SizedBox(height: 10,),


                  CupertinoButton(
                    child: const Text("Create an Account"),
                     onPressed: (){
                      Navigator.push(context,CupertinoPageRoute(
                        builder: (context)=> SignUpScreen()
                        ));
                     })
                ],
              ),
              )
          ],
        ),
        ),
    );
  }
  
  void login() {}
}