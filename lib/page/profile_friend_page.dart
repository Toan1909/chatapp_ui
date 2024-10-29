import 'package:chatapp/network/app_api.dart';
import 'package:chatapp/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/user_model.dart';
import '../utils/colors.dart';
import '../utils/style.dart';

class ProfileFriendPage extends StatefulWidget {
  String statusFriendship;
  User user;
  ProfileFriendPage(
      {super.key, required this.user, required this.statusFriendship});
  @override
  State<ProfileFriendPage> createState() => _ProfileFriendPageState();
}

class _ProfileFriendPageState extends State<ProfileFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              )),
        ),
        actions: [
          Visibility(
            visible: widget.statusFriendship == 'accepted',
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.person,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.png'), fit: BoxFit.fill)),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage('assets/avt_err.png'),
              child: ClipOval(
                child: Image.network(
                  widget.user.urlProfilePic!,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ));
                    }
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/avt_err.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.user.fullName!,
              style: AppStyles.labelText,
            ),
            Text(
              widget.user.email!,
              style: AppStyles.subLabelText,
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: widget.statusFriendship == 'accepted'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(100, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Icon(
                                Icons.chat_outlined,
                                size: 20,
                                color: Colors.white,
                              )),
                          Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(100, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Icon(
                                Icons.video_call_outlined,
                                size: 20,
                                color: Colors.white,
                              )),
                          Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(100, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Icon(
                                Icons.phone_outlined,
                                size: 20,
                                color: Colors.white,
                              )),
                          Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(100, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Icon(
                                Icons.north_east_rounded,
                                size: 20,
                                color: Colors.white,
                              )),
                        ],
                      )
                    : (widget.statusFriendship == 'pending'
                        ? TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                            ),
                            onPressed: () {

                            },
                            child: const Text('Chờ phản hồi.',style: AppStyles.labelText3,),
                          )
                        : InkWell(
                          onTap: () async {
                            var done = await Api().addFriends(widget.user.userId!);
                            if(done){
                              setState(() {
                                widget.statusFriendship='pending';
                              });
                            }
                          },
                          child: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(100, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Icon(
                                Icons.person_add,
                                size: 20,
                                color: Colors.white,
                              )),
                        ))),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Display Name", style: AppStyles.subTitle),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 22),
                      child: Text(widget.user.fullName!, style: AppStyles.labelText3),
                    ),
                    const Text("Email Address", style: AppStyles.subTitle),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 22),
                      child: Text(widget.user.email!, style: AppStyles.labelText3),
                    ),
                    const Text("Adress", style: AppStyles.subTitle),
                    const Padding(
                      padding: EdgeInsets.only(left: 12, bottom: 22),
                      child: Text("33 street west subidbazar,sylhet",
                          style: AppStyles.labelText3),
                    ),
                    const Text("Phone Number", style: AppStyles.subTitle),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 22),
                      child: Text(widget.user.phone!, style: AppStyles.labelText3),
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
