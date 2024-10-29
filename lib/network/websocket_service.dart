
import 'dart:convert';

import 'package:chatapp/shared/spref.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/response_ws_model.dart';

class WebSocketService {
  late  WebSocketChannel _channel ;
  bool _connected = false;
  static final WebSocketService _instance = WebSocketService._internal();
  WebSocketService._internal();
  factory WebSocketService() => _instance;
  void connect(String id){
    if (_connected) {
      print("Already connected to WebSocket");
      return;
    }
    final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3000/ws/message?wsId=$id'));
    _channel=channel;
    _connected =true;
  }
  Stream<ResponseWs> stream() {
    if (_channel!=null) {
      return _channel.stream.map((data) {
        final jsonMap = jsonDecode(data);
        return ResponseWs.fromJson(jsonMap);
      }).asBroadcastStream();
    }
    return const Stream.empty();
  }
  void disconnect(){
    if (!_connected) {
      print('WebSocket is already disconnected.');
      return;
    }
    _channel.sink.close();
    print('Disconnecting WebSocket');
    _connected = false;
  }
}
