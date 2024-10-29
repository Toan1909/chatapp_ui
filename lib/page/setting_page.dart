import 'package:chatapp/bloc/convers_cubit.dart';
import 'package:chatapp/bloc/friend_cubit.dart';
import 'package:chatapp/bloc/messages_cubit.dart';
import 'package:chatapp/bloc/user_profile_cubit.dart';
import 'package:chatapp/page/profile_user_page.dart';
import 'package:chatapp/page/splash.dart';
import 'package:chatapp/page/welcome_page.dart';
import 'package:chatapp/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/websocket_service.dart';
import '../shared/spref.dart';
import '../utils/colors.dart';
import '../utils/style.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: AppStyles.labelText,
          textAlign: TextAlign.center,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {
                  WebSocketService().disconnect();
                  SPref.instance.remove('token').whenComplete(() {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const SplashPage()),
                      (Route<dynamic> route) => false,
                    );
                  });
                },
                icon: const Icon(
                  Icons.logout,
                  size: 20,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 128),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.png'), fit: BoxFit.fill)),
        child: Column(
          children: [
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BlocBuilder<ProfileCubit, UserProfileState>(
                      builder: (BuildContext context, state) {
                        if (state is ProfileLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is ProfileLoaded) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileUserPage(user: state.user)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: const AssetImage(
                                        'assets/avt_err.png'),
                                    child: ClipOval(
                                      child: Image.network(
                                        state.user.urlProfilePic!,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent?
                                                loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
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
                                            Object exception,
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
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.user.fullName!,
                                          style: AppStyles.labelText2,
                                        ),
                                        const Text(
                                          'Never give up 💪',
                                          style: AppStyles.subLabelText2,
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.qr_code_scanner,
                                        size: 24,
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                        if (state is ProfileError) {
                          return Center(
                              child: Text('Error: ${state.message}'));
                        }
                        return const Center(
                            child: Text('No Information found'));
                      },
                    ),
                    const Divider(
                      thickness: 2,
                      color: Color(0xFFF5F6F6),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SettingItem(
                            title: 'Account',
                            desc: 'Privacy, security, change number',
                            icon: Icons.key,
                          ),
                          SettingItem(
                            title: 'Chat',
                            desc: 'Chat history, theme, wallpapers',
                            icon: Icons.chat_outlined,
                          ),
                          SettingItem(
                            title: 'Notifications',
                            desc: 'Messages, group and others',
                            icon: Icons.notifications_active_outlined,
                          ),
                          SettingItem(
                            title: 'Help',
                            desc: 'Help center, contact us, privacy policy',
                            icon: Icons.help_outline,
                          ),
                          SettingItem(
                            title: 'Storage and data',
                            desc: 'Network usage, storage usage',
                            icon: Icons.compare_arrows,
                          ),
                          SettingItem(
                            title: 'Invite a friend',
                            desc: '',
                            icon: Icons.person_pin_circle_outlined,
                          ),
                        ],
                      ),
                    )
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
