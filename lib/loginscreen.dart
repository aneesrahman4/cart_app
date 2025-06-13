import 'package:cart_app/routes/app_route_constants.dart';
import 'package:cart_app/widget/custom_button.dart';
import 'package:cart_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      print("Email: $email, Password: $password");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Logging in...")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Log in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      color: Color(0xFF5A78F0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email
                  CustomTextField(
                    controller: _emailController,
                    label: 'email',
                    hint: 'abc@gmail.com',
                    validator:
                        (value) =>
                            (value == null || value.isEmpty)
                                ? 'Please enter your email'
                                : null,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  CustomTextField(
                    controller: _passwordController,
                    label: 'password',
                    hint: 'abc123',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFFC4C4C4),
                      ),
                      onPressed:
                          () => setState(() {
                            _obscureText = !_obscureText;
                          }),
                    ),

                    validator:
                        (value) =>
                            (value == null || value.isEmpty)
                                ? 'Please enter password'
                                : null,
                  ),
                  const SizedBox(height: 24),

                  // Continue Button
                  SizedBox(height: 50),
                  CustomButton(onPressed: _submit, text: 'Continue'),

                  const SizedBox(height: 16),

                  // Sign up link
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              AppRouteConstants.SignupRouteName,
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Color(0xFF5A78F0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
