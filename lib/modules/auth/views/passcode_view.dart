import 'package:flutter/material.dart';

class PassCode extends StatefulWidget {
  final String phoneNumber;
  final String country;
  final String countryCode;
  final bool isNewUser;

  const PassCode({
    super.key,
    required this.phoneNumber,
    required this.country,
    required this.countryCode,
    required this.isNewUser,
  });

  @override
  State<PassCode> createState() => _PassCodeState();
}

class _PassCodeState extends State<PassCode> {
  @override
  Widget build(BuildContext context) {
    // Access the parameters using widget.phoneNumber, widget.country, etc.
    return Scaffold(
      body: Center(
        child: Text(
          'Passcode View: ${widget.phoneNumber}, ${widget.country}, ${widget.countryCode}, ${widget.isNewUser}',
        ),
      ),
    );
  }
}