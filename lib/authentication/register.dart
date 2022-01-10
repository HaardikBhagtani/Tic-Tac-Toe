import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haardik_tic_tac_toe/authentication/login.dart';
import 'package:haardik_tic_tac_toe/model/authModel.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthModel _authModel = AuthModel();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Image.asset(
                'assets/union.png',
                scale: 0.7,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: kMainColor,
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (!EmailValidator.validate(value!)) {
                          return 'This is not a valid email address';
                        }
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: kMainColor,
                          fontSize: 18,
                        ),
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.black,
                        ),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kMainColor,
                            fontSize: 18,
                          ),
                        ),
                        floatingLabelStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kMainColor,
                            fontSize: 22,
                          ),
                        ),
                        alignLabelWithHint: false,
                        fillColor: kMainColor,
                        focusColor: kMainColor,
                        hoverColor: kMainColor,
                        border: kInputBorder,
                        disabledBorder: kInputBorder,
                        focusedBorder: kInputBorder,
                        enabledBorder: kInputBorder,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 8) {
                          return 'Password needs to have 8 characters';
                        }
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: kMainColor,
                          fontSize: 18,
                        ),
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.black,
                        ),
                        labelText: 'Password',
                        labelStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kMainColor,
                            fontSize: 18,
                          ),
                        ),
                        floatingLabelStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kMainColor,
                            fontSize: 22,
                          ),
                        ),
                        alignLabelWithHint: false,
                        fillColor: kMainColor,
                        focusColor: kMainColor,
                        hoverColor: kMainColor,
                        border: kInputBorder,
                        disabledBorder: kInputBorder,
                        focusedBorder: kInputBorder,
                        enabledBorder: kInputBorder,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            String code = await _authModel.createNewUser(emailController.text, passwordController.text);
                            setState(() {
                              _loading = false;
                            });
                            if (code == 'Registration Successful. Now Login.') {
                              Fluttertoast.showToast(
                                msg: code,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: code,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          }
                        },
                        child: Text(
                          'REGISTER',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            const RoundedRectangleBorder(
                              side: BorderSide(color: kMainColor, width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
