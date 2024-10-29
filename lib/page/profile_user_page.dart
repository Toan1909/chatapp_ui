import 'package:chatapp/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/user_model.dart';
import '../utils/colors.dart';
import '../utils/style.dart';

class ProfileUserPage extends StatelessWidget {
  User user;
  ProfileUserPage({super.key,required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 22,
              )),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.png'), fit: BoxFit.fill)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [CircleAvatar(
                radius: 60,
                backgroundImage:
                const AssetImage('assets/avt_err.png'),
                child: ClipOval(
                  child: Image.network(
                    user.urlProfilePic!,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    loadingBuilder: (BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                              value:
                              loadingProgress.expectedTotalBytes !=
                                  null
                                  ? loadingProgress
                                  .cumulativeBytesLoaded /
                                  loadingProgress
                                      .expectedTotalBytes!
                                  : null,
                            ));
                      }
                    },
                    errorBuilder: (BuildContext context,
                        Object exception, StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/avt_err.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
                SizedBox(
                    height: 1,
                    width: 1,
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.add_photo_alternate_rounded,color: Colors.white70,size: 26,))),
              ]
            ),

            const SizedBox(height: 12,),
             Text(
              user.fullName!,
              style: AppStyles.labelText,
            ),
             Text(
              user.email!,
              style: AppStyles.subLabelText,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(100, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Icon(Icons.chat_outlined,size: 20,color: Colors.white,)),
                  Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(100, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Icon(Icons.video_call_outlined,size: 20,color: Colors.white,)),
                  Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(100, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Icon(Icons.phone_outlined,size: 20,color: Colors.white,)),
                  Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(100, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child:const Icon(Icons.north_east_rounded,size: 20,color: Colors.white,)),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 32,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 4,
                    width: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: lineColor),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Display Name", style: AppStyles.subTitle),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,bottom: 22),
                      child: Text(user.fullName!, style: AppStyles.labelText3),
                    ),
                    const Text("Email Address", style: AppStyles.subTitle),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,bottom: 22),
                      child: Text(user.email!, style: AppStyles.labelText3),
                    ),
                    const Text("Adress", style: AppStyles.subTitle),
                    const Padding(
                      padding: EdgeInsets.only(left: 12,bottom: 22),
                      child: Text("33 street west subidbazar,sylhet", style: AppStyles.labelText3),
                    ),
                    const Text("Phone Number", style: AppStyles.subTitle),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,bottom: 22),
                      child: Text(user.phone!, style: AppStyles.labelText3),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
