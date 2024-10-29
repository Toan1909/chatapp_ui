import 'package:chatapp/bloc/friend_cubit.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/network/app_api.dart';
import 'package:chatapp/page/pendings_page.dart';
import 'package:chatapp/page/profile_friend_page.dart';
import 'package:chatapp/widgets/friend_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/spref.dart';
import '../utils/colors.dart';
import '../utils/style.dart';

class FriendsPage extends StatelessWidget{
  const FriendsPage({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<FriendsCubit>().loadFriends();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Contacts",
          style: AppStyles.labelText,
          textAlign: TextAlign.center,
        ),
        actions: [
          Stack(
            children: [Container(
              margin: const EdgeInsets.only(right: 16),
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(100, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(
                    Icons.person_add_alt_outlined,
                    size: 24,
                    color: Colors.white,
                  )),
            ),
              BlocBuilder<FriendsCubit,FriendsState>(
                builder: (BuildContext context, FriendsState state) {
                  if (state is FriendsLoaded){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingPage(pendings: state.pendings)));
                      },
                      child: state.pendings.isEmpty==true?const Text(''):Container(
                        width: 22,
                        height: 22,
                        margin: const EdgeInsets.only(top: 30,left: 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                          border: Border.all(
                              color: Colors.white,
                              width: 3),
                        ),
                        child:  Align(
                            alignment: Alignment.center,
                            child: Text('${state.pendings.length}', style: const TextStyle(fontSize: 12,color: Colors.white),)),
                      ),
                    );
                  }
                  else {
                    return const Text('Không có bạn bè.');
                  }
                },
              )
            ]
          )
        ],
        leadingWidth: 64,
        leading: Align(
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
                color: Color.fromARGB(100, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: IconButton(
                onPressed: () {

                },
                icon: const Icon(
                  Icons.search_outlined,
                  size: 24,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      body: MediaQuery.removePadding(
        context: context,
        child: Container(
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
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: BlocBuilder<FriendsCubit,FriendsState>(
                    builder: (BuildContext context, FriendsState state) {
                      if (state is FriendsLoading){
                        return const Text('loading...');
                      }
                      else if(state is FriendsLoaded){
                        if(state.friends.isEmpty){
                          return const Center(child: Text('No friends found'));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: state.friends.length,
                            itemBuilder: (BuildContext c,int index){
                              return FriendTag(user: state.friends[index],statusFriendship:'accepted');
                            });
                      }
                      else if(state is FriendsError){
                        return Text('Error: ${state.message}');
                      } return const Text('No friends found');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
