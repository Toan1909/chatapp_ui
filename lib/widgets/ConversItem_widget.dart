import 'package:flutter/material.dart';

import '../utils/style.dart';
class ConversItem extends StatelessWidget {
  final String urlPic;
  final String name;
  final String lastMessage;
  final String lastTimeMessage;
  final bool online;
  final bool haveNewMes;
  final String newMessagesCount;
  const ConversItem(
      {super.key,
        required this.urlPic,
        required this.online,
        required this.name,
        this.lastMessage = '',
        required this.lastTimeMessage,
        this.haveNewMes = false,
        this.newMessagesCount = '0'});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Stack(children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(urlPic),
                  ),
                ),
                Visibility(
                  visible: online,
                  child: Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(top: 47, left: 47),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0FE16D),
                    ),
                  ),
                ),
              ]),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppStyles.labelText2,
                    ),
                    SizedBox(
                      width: 160,
                      child: Text(
                        lastMessage,
                        style: AppStyles.subLabelText2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ]),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lastTimeMessage,
                    style: AppStyles.subLabelText2,
                  ),
                  Visibility(
                    visible: haveNewMes,
                    child: Container(
                      alignment: Alignment.center,
                      width: 22,
                      height: 22,
                      //margin: const EdgeInsets.only(top: 47, left: 47),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF04A4C),
                      ),
                      child: Text(
                        newMessagesCount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}