import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../app/components/roundbutton.dart';
import 'otpscreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mobileController = '';

    return Scaffold(
      appBar: null,
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image(
                  image: AssetImage('images/to-do-list.png'),
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    fontFamily: 'Trirong',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow.shade800,
                        ),
                      ),
                    ),
                    cursorColor: Colors.yellow.shade800,
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      mobileController = phone.completeNumber;
                    },
                    pickerDialogStyle: PickerDialogStyle(
                      searchFieldCursorColor: Colors.yellow.shade800,
                    ),
                  ),
                ),
                RoundedButton(
                  text: 'LOGIN',
                  boxHeight: 53,
                  boxWidth: 200,
                  fontSize: 18,
                  onPressed: () {
                    if (mobileController.length == 13) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OTPScreen(mobileController)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter Valid Phone number')));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
