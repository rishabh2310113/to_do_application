import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create an account'),
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
                      labelText: "Email Adress",
                    ),
                  ),

                  const SizedBox(height: 10,),

                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),

                   const SizedBox(height: 10,),

                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                    ),
                  ),

                  const SizedBox(height: 10,),

                  CupertinoButton(
                    onPressed: (){},
                    color: Colors.blue,
                    child: const Text('Create Account'),)
                ],
              ),)
          ],
        )),
    );
  }
}