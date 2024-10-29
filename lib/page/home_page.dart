import 'package:chatapp/models/convers_model.dart';
import 'package:chatapp/network/app_api.dart';
import 'package:chatapp/page/chatting_page.dart';
import 'package:chatapp/page/friends_page.dart';
import 'package:chatapp/page/messages_page.dart';
import 'package:chatapp/page/setting_page.dart';
import 'package:chatapp/shared/spref.dart';
import 'package:chatapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/convers_cubit.dart';
import '../bloc/friend_cubit.dart';
import '../bloc/user_profile_cubit.dart';
import '../network/websocket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        ConversationCubit().loadConvers();
      case 0:
        ;
    }
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final uId = await SPref.instance.get('userId');
      if (uId == null) {
        print("Error: User ID is null.");
        return;
      }
      print("User ID: $uId");
      WebSocketService().connect(uId);
      print('=====CONNECTED WEBSOCKET=====');
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConversationCubit>.value(
          value:ConversationCubit()..loadConvers(),
        ),
        BlocProvider<FriendsCubit>.value(
          value: FriendsCubit()..loadFriends(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProfileCubit()..loadProfile(),
        )
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            const MessagePage(),
            const Text("data12"),
            const FriendsPage(),
            SettingPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.message,
                size: 24,
              ),
              label: 'Message',
              backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.phone,
                size: 24,
              ),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.addressCard,
                size: 24,
              ),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                Icons.settings,
                size: 24,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF3D4A7A),
          unselectedItemColor: const Color(0x63797C7B),
          selectedLabelStyle: AppStyles.selectedText,
          unselectedLabelStyle: AppStyles.unSelectedText,
          unselectedFontSize: 0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
