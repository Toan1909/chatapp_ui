import 'package:chatapp/network/app_api.dart';
import 'package:chatapp/page/splash.dart';
import 'package:chatapp/utils/colors.dart';
import 'package:chatapp/widgets/dialogs.dart';
import 'package:chatapp/widgets/mybutton.dart';
import 'package:chatapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../shared/spref.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _passCtl = TextEditingController();
  final TextEditingController _phoneCtl = TextEditingController();
  final TextEditingController _mailCtl = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _onLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 24,
              color: Color(0xFF000D07),
            ),
          ),
          backgroundColor: bgColor),
      body: Stack(
        children: [Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: bgColor,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Sign up with Email',
                    style: AppStyles.title,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Get chatting with friends and family today by signing up for our chat app!',
                    style: AppStyles.subTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Your name", style: AppStyles.label1),
                        TextFormField(
                          controller: _nameCtl,
                          validator: ValidationBuilder().maxLength(30,'Email require less than 50 characters').minLength(2,'Email require more than 2 characters').build(),
                          style: AppStyles.input1,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text("Your email", style: AppStyles.label1),
                        TextFormField(
                          controller:_mailCtl,
                          validator: ValidationBuilder().email("Invalid email ").maxLength(50,'Email require less than 50 characters').build(),
                          style: AppStyles.input1,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text("Your phone", style: AppStyles.label1),
                        TextFormField(
                          controller: _phoneCtl,
                          validator: ValidationBuilder().phone('Invalid phone').maxLength(50,'Phone require less than 50 characters').build(),
                          style: AppStyles.input1,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text("Password", style: AppStyles.label1),
                        TextFormField(
                          controller: _passCtl,
                          validator: ValidationBuilder().minLength(4,"Pass require greater than 4 characters").maxLength(32,"Pass require less than 32 characters").build(),
                          style: AppStyles.input1,
                        ),

                      ],
                    ),
                  ),

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
                  const SizedBox(height: 54,),

                ],
              )
            ],
          ),
        ),
          Visibility(
              visible: _onLoading,
              child: Container(
                color: Colors.black.withOpacity(0.05),
                child: Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.lightBlueAccent.withOpacity(0.6),
                        size: 60)),
              ))
        ]
      ),
    );
  }
  void _onBtnSignInPressed(){
    bool? _isNotErr= _form.currentState?.validate();
    if(_isNotErr==true){
      setState(() {
        _onLoading=true;
      });
      var fullName = _nameCtl.text;
      var email = _mailCtl.text;
      var phone = _phoneCtl.text;
      var password = _passCtl.text;
      Api().signUp(email, phone, fullName, password).then((user)async{
        await SPref.instance.set("token", user.token);
        setState(() {
          Future.delayed(const Duration(seconds: 2));
          _onLoading = false;
        });
        myDialog(context: context, title: 'Tạo tài khoản thành công', message: 'Đang vào ứng dụng...',icon: const Icon(Icons.check_circle,color: Colors.green,size: 40));
        Future.delayed(const Duration(seconds: 2)).then((_){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashPage()));
        });

      }).catchError((e){
        setState(() {
          _onLoading = false;
        });
        // Kiểm tra lỗi và hiển thị thông báo phù hợp
        String errorMessage = "";
        if (e == "Conflict Account") {
          errorMessage = "Email này đã được sử dụng cho tài khoản khác.";
        } else {
          errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại.";
        }
        // Hiển thị thông báo lỗi cho người dùng
        myDialog(
            context: context, title: "Sign Up Error :((", message: errorMessage,icon: const Icon(Icons.error,color: Colors.redAccent,size: 40));

      });
    }
  }
}
