import 'package:ecommerce/screen/register_page.dart';
import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("error"),
            content: Container(child: Text(error)),
            actions: [
              TextButton(
                  child: Text('close dialog'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  //create a new user account
  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmail, password: loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    //set form to loading state
    setState(() {
      _loginformloading = true;
    });
    //run the create account method
    String? _loginFeedBack = await _loginAccount();
    if (_loginFeedBack != null) {
      _alertDialogBuilder(_loginFeedBack);

      setState(() {
        _loginformloading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _loginformloading = false;
  //form input feild values
  String loginEmail = "";
  String loginPassword = "";
  late FocusNode passwordFocusNode;
  @override
  void initState() {
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    "welcome user,\nlogin to your account",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: 'email',
                      onchanged: (value) {
                        loginEmail = value;
                      },
                    ),
                    CustomInput(
                      hintText: 'password',
                      onchanged: (value) {
                        loginPassword = value;
                      },
                      onSubmitted: (value) {
                        _submitForm();
                      },
                      isPasswordField: true,
                    ),
                    CustomBtn(
                      text: 'login',
                      onPressed: () {
                        _submitForm();
                      },
                      outlineBtn: false,
                      isloading: _loginformloading,
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16.0,
                    ),
                    child: CustomBtn(
                      onPressed: () {
                        //Future.delayed(Duration.zero, () {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        });
                        // });
                      },
                      text: 'Create new account',
                      outlineBtn: true,
                      isloading: false,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
