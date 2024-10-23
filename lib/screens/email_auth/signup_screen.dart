import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  void createAccount() async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String cpassword = cpasswordController.text.trim();

      if(email == "" || password == "" || cpassword == ""){
            if (kDebugMode) {
              print("Please fill all the details!");
            }
      }
     
     else if(password != cpassword){
       if (kDebugMode) {
         print("Password do not match!");
       }
     }

     else{
      // creating new account
      try {
           UserCredential userCredential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Navigator.pop(context);
         }                                                                        // SNACKBAR
       }on FirebaseAuthException catch(ex){
        print(ex.code.toString());
      }
      
      }
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create an account'),
      ),
      body: SafeArea(
        child: ListView(
          children: [ 
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email Adress",
                    ),
                  ),

                  const SizedBox(height: 10,),

                   TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),

                   const SizedBox(height: 10,),

                  TextField(
                    controller: cpasswordController,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                    ),
                  ),

                  const SizedBox(height: 10,),

                  CupertinoButton(
                    onPressed: (){
                      createAccount();
                    },
                    color: Colors.blue,
                    child: const Text('Create Account'),)
                ],
              ),)
          ],
        )),
    );
  }
}