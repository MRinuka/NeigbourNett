import 'package:flutter/material.dart';
import 'resident_registration.dart';
import 'package:neigbor_connect/main.dart';
import 'otp_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  // GlobalKey to validate the Form
  final _formKey = GlobalKey<FormState>();

  // **controllers**
  final TextEditingController _buildingcodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _buildingcodeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verifying...'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushNamed(context, "/activity");



    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please correct the errors in the form.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Allows the page to scroll when keyboard appears
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Logo ---
                  const SizedBox(height: 60),
                  Image.asset(
                    "assets/images/NeighbourNett New.png",
                    height: 100,
                    width: 100,),

                  const SizedBox(height: 20),
                  Text(
                    'Verify Yourself!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Are you a tenant? Verify by entering your details below',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- Email Field ---
                  TextFormField(
                    controller: _buildingcodeController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Building Number',
                      hintText: 'Building 0015',
                      prefixIcon: Icon(Icons.apartment),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your building code';
                      }
                      // if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      //   return 'Please enter a valid building code';
                      // }
                      // return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // TextButton(onPressed: ()
                      // {
                      //   Navigator.pushNamed(context, "/otp");
                      //
                      // },
                      //     child: const Text("Log in via OTP")),
                      const SizedBox(width: 100),
                      TextButton(
                        onPressed: () {

                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- Login Button ---
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      // 1. Remove the button's own padding
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // 2. Make the button's background transparent
                      backgroundColor: Colors.transparent,
                      // 3. Remove the shadow
                      shadowColor: Colors.transparent,
                    ),
                    // 4. Use Ink for the ripple effect
                    child: Ink(
                      decoration: BoxDecoration(
                        // 5. Apply the gradient
                        gradient: const LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.lightBlueAccent
                          ], // Your gradient colors
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        // 6. Match the button's border radius
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // 7. This Container ensures the text is centered
                      child: Container(
                        // The minimumSize from styleFrom is still applied
                        alignment: Alignment.center,
                        height: 50,
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 18,
                            // 8. Change text color to be visible on gradient
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Sign Up Link ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/resident");
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
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