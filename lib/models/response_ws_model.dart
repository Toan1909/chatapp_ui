enum ResponseWsType {
  newMessage,
  addFriend,
  notification,
}

class ResponseWs {
  ResponseWsType? type;
  dynamic data;

  ResponseWs({
    this.type,
    this.data,
  });

  // Chuyển từ JSON thành ResponseWs
  factory ResponseWs.fromJson(Map<String, dynamic> json) {
    return ResponseWs(
      type: _responseTypeFromString(json['type']),
      data: json['data'],
    );
  }

  // Chuyển từ ResponseWs thành JSON
  Map<String, dynamic> toJson() {
    return {
      'type': _responseTypeToString(type),
      'data': data,
    };
  }

  // Chuyển đổi string thành enum
  static ResponseWsType? _responseTypeFromString(String? type) {
    switch (type) {
      case 'NEW_MESSAGE':
        return ResponseWsType.newMessage;
      case 'ADDFRIEND':
        return ResponseWsType.addFriend;
      case 'NOTIFICATION':
        return ResponseWsType.notification;
      default:
        return null;
    }
  }
  // Chuyển đổi enum thành string
  static String? _responseTypeToString(ResponseWsType? type) {
    switch (type) {
      case ResponseWsType.newMessage:
        return 'NEW_MESSAGE';
      case ResponseWsType.addFriend:
        return 'ADDFRIEND';
      case ResponseWsType.notification:
        return 'NOTIFICATION';
      default:
        return null;
    }
  }
}

