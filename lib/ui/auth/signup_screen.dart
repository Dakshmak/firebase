
import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loding = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      helperText: 'enter email e.g. jon@gmail.com',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Enter email';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        helperText: 'enter password',
                        prefixIcon: Icon(Icons.lock_outline)
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Enter password';
                      }
                    },
                  ),
                ],
              )
          ),
          SizedBox(height: 50,),
          RoundButton(title: 'Sign up',
            loding: loding,
            onTap: () {
            if(_formKey.currentState!.validate()){
              setState(() {
                loding = true;
              });
              _auth.createUserWithEmailAndPassword(
                  email: emailController.text.toString(),
                  password: passwordController.text.toString()).then((value) {
                    setState(() {
                      loding = false;
                    });

              }).onError((error, stackTrace) {
                utils().toastMessage(error.toString());
                setState(() {
                  loding = false;
                });
              });
            }
          },),
          Row(
            children: [
              Text("Alredy have an account"),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
                  },
                  child: Text('Login'))
            ],
          )
        ],
      ),
    );
  }
}
