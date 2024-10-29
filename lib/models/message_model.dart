import 'package:flutter/foundation.dart';

class Message {
  final String? messageId;
  final String? conversationId;
  final String? senderId;
  final String? content;
  final String? mediaUrl;
  final DateTime? sendAt;
  final List<String>? seenBy;

  Message({
    this.messageId,
    this.conversationId,
    this.senderId,
    this.content,
    this.mediaUrl,
    this.sendAt,
    this.seenBy,
  });

  // From JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['messageId'],
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      content: json['content'],
      mediaUrl: json['mediaUrl'],
      sendAt: json['sendAt'] != null ? DateTime.parse(json['sendAt']) : null,
      seenBy: json['seenBy'] != null
          ? List<String>.from(json['seenBy'])
          : null,
    );
  }
  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'conversationId': conversationId,
      'senderId': senderId,
      'content': content,
      'mediaUrl': mediaUrl,
      'sendAt': sendAt?.toIso8601String(),
      'seenBy': seenBy,
    };
  }
  static List<Message> parseMessageList(map) {
    if(map['data']==null){
      return [];
    }
    var list = map['data'] as List<dynamic>;
    return list.map((repo) =>Message.fromJson(repo)).toList();
  }
}
