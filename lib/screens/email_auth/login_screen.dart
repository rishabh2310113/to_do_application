import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/screens/email_auth/signup_screen.dart';
import 'package:to_do_application/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim(); 
    String password = passwordController.text.trim();

    if(email == "" || password == ""){
      if (kDebugMode) {
        print("Please fill all the details!");
      }
    }

    else{
       
       try{
        UserCredential userCredential = await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null){
          Navigator.popUntil(context, (route)=>route.isFirst);
          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen()));
        }
       } on FirebaseAuthException catch(ex){
        print(ex.code.toString());
       }
    }
  }

  

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
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email Address" 
                    ),
                  ),

                  const SizedBox(height: 10,),
                
                 TextField(
                  controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "password" 
                    ),
                  ),

                   const SizedBox(height: 10,),

                  CupertinoButton(
                    onPressed: (){
                      login();
                    },
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
}