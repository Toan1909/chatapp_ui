import 'package:chatapp/network/app_api.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../page/profile_friend_page.dart';
import '../utils/style.dart';

class FriendTag extends StatelessWidget {
  final User user;
  String statusFriendship;
  FriendTag({
    super.key,
    required this.user,
    required this.statusFriendship,
  }){checkFr();}
  Future<void> checkFr() async {
    statusFriendship = await Api().checkFriends(user.userId!);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileFriendPage(
                      user: user,
                      statusFriendship: statusFriendship,
                    )));
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(children: [
           Row(children: [
             SizedBox(
               width: 60,
               height: 60,
               child: CircleAvatar(
                 backgroundImage: NetworkImage(user.urlProfilePic!),
               ),
             ),
             Container(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     user.fullName!,
                     style: AppStyles.labelText2,
                   ),
                   Text(
                     user.email!,
                     style: AppStyles.subLabelText2,
                   )
                 ],
               ),
             ),
           ],)

          ])),
    );
  }
}
