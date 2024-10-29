import 'package:chatapp/network/app_api.dart';

import 'member_model.dart';

class Conversation {
  String? conversationId;
  String? conversationName;
  bool? isGroup;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ConversationMember>? members; // Thêm danh sách các thành viên

  Conversation({
    this.conversationId,
    this.conversationName,
    this.isGroup,
    this.createdAt,
    this.updatedAt,
    this.members,
  });
  factory Conversation.fromJson(Map<String, dynamic> json) {

    return Conversation(
      conversationId: json['conversationId'],
      conversationName: json['conversationName'],
      isGroup: json['isGroup'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // Phương thức chuyển từ đối tượng Dart sang JSON
  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'conversationName': conversationName,
      'isGroup': isGroup,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'members': members?.map((member) => member.toJson()).toList(),
    };
  }
  static Future<List<Conversation>> parseConversList(map) async {
    if(map['data']==null){
      return [];
    }
    var list = map['data'] as List<dynamic>;
    var listConvers = list.map((repo) => Conversation.fromJson(repo)).toList();
    for (Conversation convers in listConvers){
      convers.members = await Api().getMembers(convers.conversationId!);
    }
    return listConvers;
  }
}
