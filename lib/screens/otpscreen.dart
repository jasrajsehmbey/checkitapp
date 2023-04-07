import 'package:checkit/screens/taskscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  bool loader = false;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: Colors.yellow.shade700,
      ),
      body: !loader
          ? Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Verify ${widget.phone}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      controller: _pinPutController,
                      pinAnimationType: PinAnimationType.fade,
                      onCompleted: (pin) async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        try {
                          setState(() {
                            loader = true;
                          });
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode!,
                                      smsCode: pin))
                              .then((value) async {
                            setState(() {
                              loader = false;
                            });
                            if (value.user != null) {
                              await prefs.setBool('createdatabase', true);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskScreen()),
                                  (route) => false);
                            }
                          });
                          setState(() {
                            loader = false;
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Not a Valid OTP')));
                          setState(() {
                            loader = false;
                          });
                        }
                      },
                      onSubmitted: (pin) async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        try {
                          setState(() {
                            loader = true;
                          });
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode!,
                                      smsCode: pin))
                              .then((value) async {
                            setState(() {
                              loader = false;
                            });
                            if (value.user != null) {
                              await prefs.setBool('createdatabase', true);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskScreen()),
                                  (route) => false);
                            }
                          });
                          setState(() {
                            loader = false;
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                          setState(() {
                            loader = false;
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _verifyPhone() async {
    setState(() {
      loader = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            setState(() {
              loader = false;
            });
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => TaskScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
