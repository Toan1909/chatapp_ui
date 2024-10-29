import 'package:chatapp/bloc/messages_cubit.dart';
import 'package:chatapp/models/convers_model.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/network/app_api.dart';
import 'package:chatapp/shared/spref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../utils/style.dart';

class ChattingPage extends StatefulWidget {
  final Conversation convers;
  final List<Message> messages;
  const ChattingPage(
      {super.key, required this.convers, required this.messages});

  @override
  State<StatefulWidget> createState() => ChattingState();
}
  late String userId;
class ChattingState extends State<ChattingPage> {
  TextEditingController sendMessageCtl = TextEditingController();

  @override
  void initState() {
    _getUserId();
    super.initState();

  }
  Future<void> _getUserId() async {
    String? fetchedUserId = await SPref.instance.getUserId(); // Gọi hàm bất đồng bộ để lấy userId
    setState(() {
      userId = fetchedUserId!;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Center(child: CircularProgressIndicator()); // Hiển thị loading khi userId chưa có
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        widget.convers.members!.first.urlProfilePic!),
                  ),
                ),
                Visibility(
                  visible: widget.convers.members!.first.status!,
                  child: Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(top: 30, left: 30),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0FE16D),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width:120,
                    child: Text(
                      widget.convers.members!.first.fullName!,
                      style: AppStyles.labelText2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.convers.members!.first.status!
                        ? "Active now"
                        : "Offline",
                    style: AppStyles.subLabelText2,
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined, size: 24),
            alignment: Alignment.center,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call_outlined, size: 24),
            alignment: Alignment.center,
          ),
          const SizedBox(
            width: 18,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessagesCubit, MessagesState>(
              builder: (BuildContext context, state) {
                List<Message> messages = widget.messages;
                if (state is MessagesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MessagesLoaded) {
                  messages =
                      state.messages[widget.convers.conversationId]!.toList();
                  return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        if (messages[index].senderId == userId) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 20, maxWidth: 200),
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF3D4A7A),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Text(
                                        messages[index].content!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      DateFormat('h:m a')
                                          .format(messages[index].sendAt!),
                                      style: const TextStyle(
                                        color: Color(0x7F797C7B),
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(widget
                                          .convers
                                          .members!
                                          .first
                                          .urlProfilePic!),
                                    ),
                                  ),
                                  Text(
                                    widget.convers.members!.first.fullName!,
                                    style: const TextStyle(
                                      color: Color(0xFF000D07),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                                Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          constraints: const BoxConstraints(
                                              minWidth: 20, maxWidth: 250),
                                          padding: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF3D4A7A),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Text(
                                            messages[index].content!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          DateFormat('h:m a')
                                              .format(messages[index].sendAt!),
                                          style: const TextStyle(
                                            color: Color(0x7F797C7B),
                                            fontSize: 10,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (state is MessagesError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(child: Text('No message found'));
              },
            ),
          ),
          Container(
            height: 54,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file,
                      size: 24,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 24,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic_none_rounded,
                      size: 24,
                    )),
                Expanded(
                  child: TextField(
                    controller: sendMessageCtl,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Color(0x7F797C7B),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                      hintText: 'Write your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await Api().sendMessage(widget.convers.conversationId!,
                          sendMessageCtl.text, "", userId);
                      sendMessageCtl.text = "";
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 24,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
