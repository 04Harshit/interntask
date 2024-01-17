import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../consts.dart';
import '../widgets/action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            child: Column(
              children: [
                // Discord Logo
                const SizedBox(height: 30),
                SvgPicture.asset("assets/Ills/Discord.svg"),

                // Illustrations
                const SizedBox(height: 30),
                SvgPicture.asset("assets/Ills/Illustrations.svg"),

                // Header
                const SizedBox(height: 30),
                const Text(
                  'Welcome to Discord',
                  style: kScreenHeading,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7,
                  ),
                  child: const Text(
                    'Join over 100 million people who use Discord to talk with communities and friends.',
                    style: kScreenDesc,
                    textAlign: TextAlign.center,
                  ),
                ),

                // Register
                const SizedBox(height: 30),
                ActionButton(
                  colour: const Color(0xFF5A64EA),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  label: 'Register',
                ),

                //Login
                const SizedBox(height: 12),
                ActionButton(
                  colour: const Color(0xFF777E8C),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  label: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
