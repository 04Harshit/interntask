import 'package:flutter/material.dart';
import 'package:interntask/consts.dart';
import 'package:interntask/networking/api_call.dart';
import 'package:interntask/utils/helpers.dart';
import 'package:interntask/widgets/action_button.dart';
import '../widgets/text_field_input.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final apiCall = ApiCall();

  Future<void> loginUser(BuildContext context) async {
    //checking if password and email are not empty
    if (_passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      String payload = jsonEncode({
        'username': _emailController.text,
        'password': _passwordController.text,
      });

      //login api call
      Map<String, dynamic> response =
          await apiCall.login("auth/login", payload);

      if (response["statusCode"] == 200) {
        //If successfully logged in
        Navigator.pushNamed(context, '/tasks');
      } else {
        Helper().showSnackBar(context, 'Invalid Email or Password');
      }
    } else {
      Helper().showSnackBar(context, 'Either email or password is empty');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF53575E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  label: const Text(
                    'Back',
                    style: kBackButton,
                  ),
                ),

                // Header
                const SizedBox(height: 32),
                const Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Welcome back!',
                      style: kScreenHeading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'We\'re so excited to see you again!',
                      style: kScreenDesc2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Form
                const SizedBox(height: 32),
                const Text('ACCOUNT INFORMATION', style: kTextFieldLabel),
                const SizedBox(height: 12),

                // Email field
                TextFieldInput(
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Email or Phone Number',
                ),
                const SizedBox(height: 12),

                // Password Field
                TextFieldInput(
                  textEditingController: _passwordController,
                  textInputType: TextInputType.text,
                  hintText: 'Password',
                  isPass: true,
                  showIcon: true,
                ),

                const SizedBox(height: 12),
                const Text('Forgot your password?', style: kForgetPassword),

                // Login Button
                const SizedBox(height: 12),
                ActionButton(
                  colour: const Color(0xFF5A64EA),
                  label: 'Login',
                  onPressed: () {
                    loginUser(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}