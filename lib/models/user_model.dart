class User {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? password;
  final String? urlProfilePic;
  final bool? status;
  final DateTime? createdAt;
  final String? token;

  User({
    this.userId,
    this.fullName,
    this.email,
    this.phone,
    this.password,
    this.urlProfilePic,
    this.status,
    this.createdAt,
    this.token,
  });

  // Tạo phương thức từ JSON để parse data từ server
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      urlProfilePic: json['urlProfilePic'],
      status: json['status'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      token: json['token'],
    );
  }

  // Phương thức để convert object User thành JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'urlProfilePic': urlProfilePic,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'token': token,
    };
  }
  static List<User> parseUserList(map) {
    if(map['data']==null){
      return [];
    }
    var list = map['data'] as List<dynamic>;

    var listUser = list.map((u) => User.fromJson(u)).toList();

    return listUser;
  }
}
