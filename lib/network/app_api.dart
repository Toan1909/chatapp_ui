import 'dart:async';

import 'package:chatapp/models/convers_model.dart';
import 'package:chatapp/models/member_model.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/network/app_service.dart';
import 'package:chatapp/shared/spref.dart';
import 'package:dio/dio.dart';

import '../models/user_model.dart';

class Api {
  //AUTH======================================================================================================
  Future<User> signUp(String email, String phone, String fullName, String password) async {
    var c = Completer<User>();
    try {
      var response = await AppService.instance.dio.post('/user/sign-up', data: {
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'password': password
      });
      if (response.statusCode == 200) {
        print('SignUp thành công user: ${response.data}');
        var result = User.fromJson(response.data['data']);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        c.completeError('Conflict Account');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  Future<User> signIn(String email, String password) async {
    var c = Completer<User>();
    try {
      var response = await AppService.instance.dio
          .post('/user/sign-in', data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        print('SignIn thành công user: ${response.data}');
        var result = User.fromJson(response.data['data']);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        c.completeError('Error UnAuthorized');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  Future<User> getProfile() async {
    var c = Completer<User>();
    try {
      var response = await AppService.instance.dio.get('/friends/profile');
      if (response.statusCode == 200) {
        print('Fetch profile user done.: ${response.data}');
        var result = User.fromJson(response.data['data']);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        c.completeError('User not found');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  //SEARCH====================================================================================================
  Future<User> searchUser(String key) async {
    var c = Completer<User>();
    try {
      var response = await AppService.instance.dio.post('/friends/search',data: {'email': key,'phone': key},);
      if (response.statusCode == 200) {
        print('Search user done.: ${response.data}');
        var result = User.fromJson(response.data['data']);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        c.completeError('User not found');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  //DATA=====================================================================================================
  Future<List<User>> getFriends(String uId) async {
    var c = Completer<List<User>>();
    try {
      var response = await AppService.instance.dio.post('/friends/list-friend',data: {'userId':uId});
      if (response.statusCode == 200) {
        print('Fetch list friend done.: ${response.data}');
        var result = User.parseUserList(response.data);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        c.completeError('Friends list is empty.');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  Future<List<User>> getPendings(String uId) async {
    var c = Completer<List<User>>();
    try {
      var response = await AppService.instance.dio.post('/friends/list-pending',data: {'userId':uId});
      if (response.statusCode == 200) {
        print('Fetch list pending done.: ${response.data}');
        var result = User.parseUserList(response.data);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        c.completeError('Pending list is empty.');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  Future<List<Conversation>> getConversations() async {
    var c = Completer<List<Conversation>>();
    try {
      var response = await AppService.instance.dio.get('/convers/list');
      if (response.statusCode == 200) {
        print('Load list Conversation done.: ${response.data}');
        var result = Conversation.parseConversList(response.data);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        c.completeError('Error NotFound');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  Future<Conversation> createConversation(List<String> members) async {
    var c = Completer<Conversation>();
    try {
      String uId = await SPref.instance.get('userId');
      members.add(uId);
      var response = await AppService.instance.dio.post('/convers/create',data: {
        'listMember':members,
        'conversationName':''
      });
      if (response.statusCode == 200) {
        print('Create Conversation done.: ${response.data}');
        var result = Conversation.fromJson(response.data);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 422) {
        c.completeError('Error Server');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }

  Future<List<ConversationMember>> getMembers(String conversationId) async {
    var c = Completer<List<ConversationMember>>();
    try {
      var response = await AppService.instance.dio.post('/convers/list/mem',data: {'conversationId':conversationId});
      if (response.statusCode == 200) {
        print('Load list Member done.: ${response.data}');
        var result = ConversationMember.parseMemberList(response.data);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        c.completeError('Error NotFound');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  //FRIEND====================================================================================================
  Future<String> checkFriends(String uId) async {
    var c = Completer<String>();
    try {
      var response = await AppService.instance.dio.post('/friends/check-friend',data: {'friendId':uId});
      if (response.statusCode == 200) {
        print('Check friend done.: ${response.data}');
        var result = response.data['data'] as String;
        c.complete(result);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  Future<bool> addFriends(String uId) async {
    var c = Completer<bool>();
    try {
      var response = await AppService.instance.dio.post('/friends/friendship',data: {'friendId':uId});
      if (response.statusCode == 200) {
        print('Add friend done.: ${response.data}');
        var result = (response.data['data'])!=null ;
        c.complete(result);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  Future<bool> accept(String uId) async {
    var c = Completer<bool>();
    try {
      var response = await AppService.instance.dio.put('/friends/accept',data: {'friendId':uId});
      if (response.statusCode == 200) {
        print('Accept friend done.: ${response.data}');
        c.complete(true);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  //MESSAGE===================================================================================================
  Future<List<Message>> getMessages(String conversationId) async {
    var c = Completer<List<Message>>();
    try {
      var response = await AppService.instance.dio.post('/convers/message/list',data: {'conversId':conversationId});
      if (response.statusCode == 200) {
        print('Load data message done.: ${response.data}');
        var result = Message.parseMessageList(response.data);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        c.completeError('Error UnAuthorized');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  Future<Message> sendMessage(String conversationId, String content, String mediaUrl,String senderId) async {
    var c = Completer<Message>();
    try {
      var response = await AppService.instance.dio.post('/convers/message/send', data: {
        'conversationId': conversationId,
        'senderId': senderId,
        'content': content,
        'mediaUrl': mediaUrl
      });
      if (response.statusCode == 200) {
        print('Send message thành công ${response.data}');
        var result = Message.fromJson(response.data['data']);
        c.complete(result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        c.completeError('Send message fail');
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }
  void seenMessage(String conversationId,String messageId) async {
    try {
      var response = await AppService.instance.dio.put('/convers/message/seen',data: {'conversationId':conversationId,
        'messageId':messageId
      });
      if (response.statusCode == 200) {
        print('${response.data['message']}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
