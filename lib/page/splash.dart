import 'package:chatapp/network/app_api.dart';
import 'package:chatapp/page/home_page.dart';
import 'package:chatapp/page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../shared/spref.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _navigation() async {
    var token = await SPref.instance.get("token");
    print("Token received: $token");

    if (token != null) {
      print("Navigating to HomePage with token");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print("No token, navigating to WelcomePage");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    }
  }
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      _navigation();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.png'), fit: BoxFit.cover)),
        child: Center(
          child: Stack(
              alignment: Alignment.center,
              children: [
            Icon(
              Icons.chat_bubble,
              size: MediaQuery.of(context).size.width - 50,
              color: const Color.fromARGB(50, 255, 255, 255),
            ),
            Container(child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.white,
              size: 80,
            ),)
          ]),
        ),
      ),
    );
  }
}
