import 'dart:async'; // Required for the timer
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart'; // Import the package

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
    // required this.verificationDetail,
  });

  // Pass the phone number or email to this page to display it
  // final String verificationDetail;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  // Timer logic
  Timer? _timer;
  int _start = 30; // 30-second timer
  bool _isResendButtonActive = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _isResendButtonActive = false; // Disable button when timer starts
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendButtonActive = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendCode() {
    // TODO: Implement your code resend logic here
    // For example, call your auth service
    // authService.resendOtp(widget.verificationDetail);

    // After calling, restart the timer
    setState(() {
      _start = 30; // Reset timer
    });
    _startTimer();

    // Show a confirmation snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new code has been sent.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _verifyOtp(String pin) {
    _focusNode.unfocus();

    if (_formKey.currentState!.validate()) {
      // TODO: Implement your actual OTP verification logic



      // For demonstration, we'll just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verifying OTP $pin...'),
          backgroundColor: Colors.blue,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        // TODO: Replace this with your actual navigation
        // For example, to your MainLayout:
        Navigator.pushNamed(context, "/home");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification Successful! (Demo)'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    _timer?.cancel(); // Important: cancel timer on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This is the styling for the Pinput boxes
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  // --- Header ---
                  Icon(
                    Icons.security_update_good_outlined,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Enter Verification Code',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We sent a 4-digit code to your number',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- Pinput Field ---
                  Pinput(
                    length: 4,
                    controller: _pinController,
                    focusNode: _focusNode,
                    defaultPinTheme: defaultPinTheme,
                    // Validator
                    validator: (pin) {
                      if (pin == null || pin.isEmpty) {
                        return 'Please enter the code';
                      }
                      if (pin.length < 4) {
                        return 'Please enter all 4 digits';
                      }
                      return null;
                    },
                    // Style for focused state
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    // Style for submitted state
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: Colors.green.shade100,
                        border: Border.all(color: Colors.green),
                      ),
                    ),
                    // Style for error state
                    errorPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: Colors.red.shade100,
                        border: Border.all(color: Colors.red),
                      ),
                    ),
                    // When all digits are entered
                    onCompleted: (pin) {
                      _verifyOtp(pin);
                    },
                  ),
                  const SizedBox(height: 30),

                  // --- Verify Button ---
                  ElevatedButton(
                    onPressed: () {
                      _verifyOtp(_pinController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.lightBlueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Resend Code ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive the code?"),
                      TextButton(
                        // Disable button if timer is active
                        onPressed: _isResendButtonActive ? _resendCode : null,
                        child: Text(
                          _isResendButtonActive
                              ? 'Resend Code'
                              : 'Resend in $_start s',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isResendButtonActive
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}