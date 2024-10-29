import 'package:chatapp/page/sign_in_page.dart';
import 'package:chatapp/page/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import '../widgets/mybutton.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg1.png'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Connect friends easily & quickly',
              style: TextStyle(
                color: Colors.white,
                fontSize: 68,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Our chat app is the perfect way to stay connected with friends and family.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(100, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: SvgPicture.asset(
                      'assets/fb_logo.svg',
                      height: 24,
                      width: 24,
                    )),
                const SizedBox(
                  width: 32,
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(100, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: SvgPicture.asset(
                    'assets/apple_logo.svg',
                    height: 24,
                    width: 24,
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(100, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: SvgPicture.asset(
                    'assets/gg_logo.svg',
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  color: lineColor,
                  thickness: 1,
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                      height: 0.07,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: lineColor,
                  thickness: 1,
                )),
              ],
            ),
            MyElevatedButton(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(100, 255, 255, 255),
                Color.fromARGB(100, 255, 255, 255),
              ]),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage() ));
              },
              borderRadius: BorderRadius.circular(10),
              width: double.infinity,
              child: const Text(
                'Sign up with email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Existing account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.10,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInPage() ));
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.10,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
