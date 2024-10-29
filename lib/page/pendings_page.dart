import 'package:chatapp/bloc/friend_cubit.dart';
import 'package:chatapp/network/app_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import '../widgets/friend_tag.dart';

class PendingPage extends StatefulWidget {
  final List<User> pendings;
  const PendingPage({super.key, required this.pendings});

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  late List<bool> acceptedState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    acceptedState = List<bool>.generate(widget.pendings.length, (index) => false);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Pendings",
          style: AppStyles.labelText,
          textAlign: TextAlign.center,
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
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: widget.pendings.isEmpty==true?const Text("Không có lời mời kết bạn ") : ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.pendings.length,
                      itemBuilder: (BuildContext c, int index) {
                        return Row(
                          children: [
                            Expanded(
                                child: FriendTag(
                                    user: widget.pendings[index],
                                    statusFriendship: 'accepted')),
                            Align(
                                child: acceptedState[index] == true
                                    ? const Text("ACCEPTED")
                                    : Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              bool success   = await Api().accept(
                                                  widget.pendings[index]
                                                      .userId!);
                                              List<String> mems = [];
                                              mems.add(widget.pendings[index].userId!);
                                              await Api().createConversation(mems);
                                              if(success){
                                                FriendsCubit().loadFriends();
                                                setState(() {
                                                  acceptedState[index]=true;
                                                });
                                              }
                                            },
                                            child: Container(
                                                width: 44,
                                                height: 44,
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        20, 0, 0, 0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                child: const Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  size: 24,
                                                  color: Colors.black54,
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              width: 44,
                                              height: 44,
                                              decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      20, 0, 0, 0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                              child: const Icon(
                                                Icons.highlight_remove,
                                                size: 24,
                                                color: Colors.black54,
                                              )),
                                        ],
                                      ))
                          ],
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
