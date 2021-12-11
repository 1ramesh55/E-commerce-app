import 'package:ecommerce/screen/constants.dart';
import 'package:ecommerce/screen/home_page.dart';
import 'package:ecommerce/screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Landingpage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                body: Center(
              child: Text('Error:${snapshot.error}'),
            ));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            //streambuilder can check the login state live
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamsnapshot) {
                  if (streamsnapshot.hasError) {
                    return Scaffold(
                        body: Center(
                      child: Text('Error:${streamsnapshot.error}'),
                    ));
                  }
                  //connection state active-do the user login check inside the id st
                  if (streamsnapshot.connectionState ==
                      ConnectionState.active) {
                    //get the user
                    User? _user = streamsnapshot.data as User?;
                    if (_user == null) {
                      //login vaxaina vane go to login page
                      return LoginPage();
                      //loggein xa vane go to home page
                    } else {
                      return Homepage();
                    }
                  }
                  //checking the auth state-loadning
                  return Scaffold(
                    body: Center(
                      child: Text(
                        'checking authentication...',
                        style: Constants.regulerHeading,
                      ),
                    ),
                  );
                });
          }
          //connecting to firebase
          return Scaffold(
            body: Center(
              child: Text(
                'initializing app...',
                style: Constants.regulerHeading,
              ),
            ),
          );
        });
  }
}
