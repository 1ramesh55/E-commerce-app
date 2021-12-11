import 'package:ecommerce/screen/constants.dart';
import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

// ignore: camel_case_types
class _RegisterPageState extends State<RegisterPage> {
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
  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerEmail, password: registerPassword);
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
      _registerformloading = true;
    });
    //run the create account method
    String? _createAccountFeedBack = await _createAccount();
    if (_createAccountFeedBack != null) {
      _alertDialogBuilder(_createAccountFeedBack);

      setState(() {
        _registerformloading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerformloading = false;
  //form input feild values
  String registerEmail = "";
  String registerPassword = "";
  //focusnode for the input field
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
                    "Create new Account",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: 'email',
                      onchanged: (value) {
                        registerEmail = value;
                      },
                      onSubmitted: (value) {
                        passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                        hintText: 'password',
                        onchanged: (value) {
                          registerPassword = value;
                        },
                        focusNode: passwordFocusNode,
                        isPasswordField: true,
                        onSubmitted: (value) {
                          _submitForm();
                        }),
                    CustomBtn(
                      text: 'create new account',
                      onPressed: () {
                        // setState(() {
                        //   _registerformloading = true;
                        // });
                        _submitForm();
                      },
                      isloading: _registerformloading,
                      outlineBtn: true,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: CustomBtn(
                    text: 'Back to login',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    outlineBtn: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
