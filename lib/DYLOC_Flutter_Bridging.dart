// import 'package:flutter/services.dart';
// import 'package:my_flutter/DYL_userManager.dart';

// /**
//    * （2）EventChannel：Native调用Flutter App
//    */
// const EventChannel _eventChannel = EventChannel('userManager');

// void listenNativeEvent() {
//   _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
// }

// void _onEvent(dynamic event) {
//   UserManager().token = event["token"];
//   print("Battery status: ${event == 'charging' ? '' : 'dis'}charging.");
// }

// void _onError(Object error) {
//   print('Battery status: unknown.');
// }
