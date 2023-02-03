import 'package:firebase/Posts/home_screen.dart';
import 'package:firebase/ui/auth/signup_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){

    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()
    ).then((value) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      utils().toastMessage(error.toString());
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
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
            ),
            SizedBox(height: 50,),
            RoundButton(title: 'Login',onTap: () {
              if(_formKey.currentState!.validate()){
                login();
              }
            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Don't have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen() ));
                    },
                    child: Text('Sign up',))
              ],
            )
          ],
        ),
      ),
    );
  }
}
