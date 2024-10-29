import 'package:chatapp/bloc/convers_cubit.dart';
import 'package:chatapp/bloc/friend_cubit.dart';
import 'package:chatapp/bloc/messages_cubit.dart';
import 'package:chatapp/page/chatting_page.dart';
import 'package:chatapp/page/profile_user_page.dart';
import 'package:chatapp/page/search_page.dart';
import 'package:chatapp/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/user_profile_cubit.dart';
import '../utils/colors.dart';
import '../widgets/ConversItem_widget.dart';
import '../widgets/circle_img_with_text_widget.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SearchWidget(),
              const Text(
                "Home",
                style: AppStyles.labelText,
                textAlign: TextAlign.center,
              ),
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
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: const AssetImage(
                            'assets/avt_err.png'),
                        child: ClipOval(
                          child: Image.network(
                            state.user.urlProfilePic!,
                            fit: BoxFit.cover,
                            width: 48,
                            height: 48,
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
            ],
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 128),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.png'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: BlocBuilder<FriendsCubit,FriendsState>(
                  builder: (BuildContext context, state) {
                    if (state is FriendsLoading) {
                    return  ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Shimmer.fromColors(baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Column(
                                children: [
                                  Container(
                                    width: 64.0,
                                    height: 64.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Container(
                                    width: 64.0,
                                    height: 14.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),),
                          );
                        });
                  }
                    if (state is FriendsLoaded){
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: state.friends.length,
                          itemBuilder: (context, index){
                            return CircleImageWithTextUnder(
                              sizeZ: 64,
                              urlImg: state.friends[index].urlProfilePic!,
                              text: state.friends[index].fullName!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              callback: () {},
                            );
                          }
                      );
                    }
                    if (state is FriendsError) {
                      return  ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Shimmer.fromColors(baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 64.0,
                                      height: 64.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      width: 64.0,
                                      height: 14.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),),
                            );
                          });
                    }
                    return  const Text('');
                    },
                ),
              ),
              SizedBox(
                height: 32,
                child: Stack(
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
              ),
              Container(
                color: Colors.white,
                child: BlocBuilder<ConversationCubit,ConversationState>(
                    builder: (BuildContext context,state){
                      if(state is ConversationLoading){
                        return SizedBox(
                            height: MediaQuery.of(context).size.height*0.7,
                            child: const ShimmerWidget( count: 5,));
                      }
                      else if(state is ConversationLoaded){
                        if (state.conversations.isEmpty){
                          return Container(
                            height: MediaQuery.of(context).size.height*0.7,
                              color: Colors.white,
                              child: const Center(child: Text('No message found')));
                        }
                        var conversations = state.conversations;
                        return BlocProvider(
                          create: (BuildContext context) { return MessagesCubit(conversations)..loadMessage(); },
                          child: BlocBuilder<MessagesCubit,MessagesState>(
                            builder: (BuildContext context,state){
                              if(state is MessagesLoading){
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: Colors.white,
                                    margin: const EdgeInsets.all(8),
                                    width: double.infinity,
                                    height: 60,
                                  ),
                                );
                              }
                              if(state is MessagesLoaded){
                                return ListView.builder(
                                  padding: const EdgeInsets.only(top: 0),
                                  shrinkWrap: true, // Để cho ListView chỉ co theo nội dung
                                  physics:
                                  const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn riêng của ListView
                                  scrollDirection: Axis.vertical,
                                  itemCount: conversations.length>9?conversations.length:9,
                                  itemBuilder: (context, index) {
                                    if(index<conversations.length){
                                      return InkWell(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>BlocProvider.value(
                                            value: BlocProvider.of<MessagesCubit>(context),// Truyền MessagesCubit hiện tại
                                            child: ChattingPage(convers: conversations[index],messages: state.messages[conversations[index].conversationId]!,))));},
                                        child: ConversItem(
                                          haveNewMes: false,
                                          newMessagesCount: '3',
                                          urlPic: conversations[index].isGroup!?'assets/avt_default.png':conversations[index].members!.first.urlProfilePic!,
                                          online: conversations[index].members!.first.status!,
                                          name: conversations[index].members!.first.fullName!,
                                          lastMessage: (state.messages[conversations[index].conversationId]?.isEmpty ?? true)
                                              ? ''
                                              : state.messages[conversations[index].conversationId]!.first.content!,
                                          lastTimeMessage: '2 min ago',
                                        ),
                                      );}
                                    else {
                                      return Container(
                                        height: 68,
                                        width: MediaQuery.of(context).size.width,
                                        color:Colors.white,
                                      );
                                    }
                                  },
                                );
                              }
                              return Container(
                                  color: Colors.white,
                                  child: const Center(child: Text('No message found')));
                            },
                          ),
                        );
                      }
                      else if(state is ConversationError){
                        return Center(child: Text('Error conversation: ${state.message}'));
                      }
                      return Container(
                          color: Colors.white,
                          child: const Center(child: Text('No conversations found')));
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key, required this.count,
  });
  final int count;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 60,
          ),
        );
      },

    );
  }
}

