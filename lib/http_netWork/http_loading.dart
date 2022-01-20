import 'package:flutter_easyloading/flutter_easyloading.dart';

bool loadingStatus = false;

class LoadingUtils {

  static show({required String showMsg}) {
    EasyLoading.show(status: showMsg);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}


