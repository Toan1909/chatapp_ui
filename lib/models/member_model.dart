import 'dart:convert';

class ConversationMember {
  String? userId;
  String? fullName;
  String? phone;
  String? urlProfilePic;
  bool? status;
  DateTime? joinedAt;

  ConversationMember({
    this.userId,
    this.fullName,
    this.phone,
    this.urlProfilePic,
    this.status,
    this.joinedAt,
  });

  // Phương thức chuyển từ JSON sang đối tượng Dart
  factory ConversationMember.fromJson(Map<String, dynamic> json) {
    return ConversationMember(
      userId: json['userId'],
      fullName: json['fullName'],
      phone: json['phone'],
      urlProfilePic: json['urlProfilePic'],
      status: json['status'],
      joinedAt: json['joinedAt'] != null ? DateTime.parse(json['joinedAt']) : null,
    );
  }

  // Phương thức chuyển từ đối tượng Dart sang JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'phone': phone,
      'urlProfilePic': urlProfilePic,
      'status': status,
      'joinedAt': joinedAt?.toIso8601String(),
    };
  }
  static List<ConversationMember> parseMemberList(map) {
    if(map['data']==null){
      return [];
    }
    var list = map['data'] as List<dynamic>;
    return list.map((repo) =>ConversationMember.fromJson(repo)).toList();
  }
}
