import 'package:beben_pos_desktop/dashboard.dart';
import 'package:beben_pos_desktop/main.dart';
import 'package:beben_pos_desktop/profile/bloc/profile_bloc.dart';
import 'package:beben_pos_desktop/utils/global_color_palette.dart';
import 'package:beben_pos_desktop/utils/global_functions.dart';
import 'package:beben_pos_desktop/utils/size_config.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

import 'bloc/session_bloc.dart';

class LoginScreen extends StatefulWidget {
  static final _scafoldKey = new GlobalKey<ScaffoldState>();
  static final _formKey = new GlobalKey<FormState>();

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";
  bool _obscureText = true;

  void validateAndSave() {
    if (LoginScreen._formKey.currentState!.validate()) {
      GlobalFunctions.logPrint("Test", "Test");
      SessionBloc().login(_username, _password, context).then((value) {
      });
    } else {
      BotToast.showText(text: 'Please Check Your input again');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return MaterialApp(
      home: Scaffold(
        key: LoginScreen._scafoldKey,
        body: Container(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/ic_logo.png', width: SizeConfig.screenWidth * 0.3,),
                      Container(
                        margin: EdgeInsets.all(24),
                        child: Form(
                            key: LoginScreen._formKey,
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Card(
                                  color: GlobalColorPalette.colorPrimaryGreen,
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Card(
                                            child: Container(
                                              width: SizeConfig.screenWidth * 0.4,
                                              child: TextFormField(
                                                onChanged: (newInput) {
                                                  _username = newInput;
                                                },
                                                keyboardType: TextInputType.text,
                                                style: TextStyle(
                                                    fontSize: 14, height: 1),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your username';
                                                  }
                                                  return null;
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  isDense: true,
                                                  prefixIcon: Icon(
                                                    Icons.person,
                                                    color: Colors.lightBlue[800],
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          6.0, 18.0, 6.0, 18.0),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0),
                                                  ),
                                                  hintText: 'Username',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            child: Container(
                                              width: SizeConfig.screenWidth * 0.4,
                                              child: TextFormField(
                                                onChanged: (newInput) {
                                                  _password = newInput;
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your password';
                                                  }
                                                  return null;
                                                },
                                                keyboardType: TextInputType.text,
                                                obscureText: _obscureText,
                                                style: TextStyle(
                                                    fontSize: 14, height: 1),
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  isDense: true,
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      // Based on passwordVisible state choose the icon
                                                      !_obscureText ? Icons.visibility : Icons.visibility_off,
                                                      color: Theme.of(context).primaryColorDark,
                                                    ),
                                                    onPressed: _toggle,
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.lock_open,
                                                    color: Colors.lightBlue[800],
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          6.0, 18.0, 6.0, 18.0),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0),
                                                  ),
                                                  hintText: 'Password',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.4,
                                            margin: EdgeInsets.only(top: 18),
                                            height: 40,
                                            child: ElevatedButton(
                                              onPressed: validateAndSave,
                                              style: ElevatedButton.styleFrom(
                                                primary: GlobalColorPalette.colorButtonActive,
                                                shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          4.0),
                                                ),
                                              ), child:  Text(
                                              'Login',
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                            ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
