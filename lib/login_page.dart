// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs, avoid_print
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uis.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/ic.dart'; 

import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:io';
import 'package:flutter/foundation.dart';

bool get isIOS => !kIsWeb && Platform.isIOS;
bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isWeb => kIsWeb;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // put your client id here
  clientId: isAndroid
      ? ''
      : '',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget apptitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Text(
        'CollabTasks 📝',
        style: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget iconWithText(_icon, text) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Iconify(
          _icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          apptitle(),
          
          Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
Container(
  padding: EdgeInsets.symmetric(vertical: 10.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GoogleUserCircleAvatar(
        identity: user,
      ),
      SizedBox(width: 10.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.displayName ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(user.email),
        ],
      ),
    ],
  ),
),
  ],
),
          // const Text('Signed in successfully.'),
          // Text(_contactText),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: Navigator.of(context).pop,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: iconWithText(Ic.round_home, 'Back to home'),
                  )),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: _handleSignOut,
                  onLongPress: Navigator.of(context).pop,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: iconWithText(Uis.signout, 'Sign out'),
                  )),
            ],
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          apptitle(),
          // const Text('You are not currently signed in.'),
          ElevatedButton(
              onPressed: _handleSignIn,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(color: Colors.blue),
                child: iconWithText(Ion.logo_google, 'Sign in with Google'),
              )),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(),
    ));
  }
}
