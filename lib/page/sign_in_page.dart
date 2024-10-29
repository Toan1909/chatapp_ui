import 'package:chatapp/page/splash.dart';
import 'package:chatapp/utils/colors.dart';
import 'package:chatapp/widgets/mybutton.dart';
import 'package:chatapp/page/sign_up_page.dart';
import 'package:chatapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../network/app_api.dart';
import '../shared/spref.dart';
import '../widgets/dialogs.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final TextEditingController _mailCtl = TextEditingController();
  final TextEditingController _passCtl = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _onLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 24,
              color: Color(0xFF000D07),
            ),
          ),
          backgroundColor: bgColor),
      body: SingleChildScrollView(
        child: Stack(
          children: [Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 80,right: 16,bottom: 16,left: 16),
            color: bgColor,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    const Text(
                      'Log in to Chatbox',
                      style: AppStyles.title,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      'Welcome back! Sign in using your social\naccount or email to continue us',
                      style: AppStyles.subTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/fb_logo.svg',height: 24,width: 24,),
                        const SizedBox(
                          width: 32,
                        ),
                        SvgPicture.asset('assets/apple_logo.svg',height: 24,width: 24,),
                        const SizedBox(
                          width: 32,
                        ),
                        SvgPicture.asset('assets/gg_logo.svg',height: 24,width: 24,),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
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
                              color: Color(0xFF797C7B),
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
                    const SizedBox(
                      height: 32,
                    ),
                    Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Your email", style: AppStyles.label1),
                          TextFormField(
                            controller: _mailCtl,
                            validator: ValidationBuilder().email("Invalid email ").maxLength(50,'Email require less than 50 characters').build(),
                            style: AppStyles.input1,
                          ),
                          const SizedBox(
                            height: 52,
                          ),
                          const Text("Password", style: AppStyles.label1),
                          TextFormField(
                            controller: _passCtl,
                            validator: ValidationBuilder().minLength(4,"Name require greater than 4 characters").maxLength(32,"Name require less than 32 characters").build(),
                            style: AppStyles.input1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    MyElevatedButton(
                      onPressed:_onBtnSignInPressed,
                      borderRadius: BorderRadius.circular(10),
                      width: double.infinity,
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignUpPage()));
                        },
                        child: const Text(
                          "Don't have a account? Sign up now!",
                          style: TextStyle(
                            color: Color(0xFF3D4A7A),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.10,
                          ),
                        )),
                    const SizedBox(height: 64,)
                  ],
                )
              ],
            ),
          ),
            Visibility(
                visible:_onLoading,
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  child: Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: const Color(0xFF3D4A7A).withOpacity(0.6),
                          size: 60)),
                ))
          ]
        ),
      ),
    );
  }
  void _onBtnSignInPressed(){
    bool? _isNotErr= _form.currentState?.validate();
    if(_isNotErr==true){
      setState(() {
        _onLoading=true;
        Future.delayed(const Duration(seconds: 2));
      });
      var email = _mailCtl.text;
      var password = _passCtl.text;
      Api().signIn(email, password).then((user)async{
        await SPref.instance.set("token", user.token);
        await SPref.instance.set("userId", user.userId);
        setState(() {
          _onLoading = false;
        });
        myDialog(context: context, title: 'Đăng nhập thành công', message: 'Đang vào ứng dụng...',icon: const Icon(Icons.check_circle,color: Colors.green,size: 40,));
        Future.delayed(const Duration(seconds: 2)).then((_){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashPage()));
        });

      }).catchError((e){
        setState(() {
          _onLoading = false;
        });
        // Kiểm tra lỗi và hiển thị thông báo phù hợp
        String errorMessage = "";
        if (e == "Error UnAuthorized") {
          errorMessage = "Sai tài khoản hoặc mật khẩu. Vui lòng thử lại";
        } else {
          errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại.";
        }
        // Hiển thị thông báo lỗi cho người dùng
        myDialog(
            context: context, title: "Log in Error :((", message: errorMessage,icon: const Icon(Icons.error,color: Colors.redAccent,size: 40));

      });
    }
  }
}
