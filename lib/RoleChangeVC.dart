import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/DYL_userManager.dart';
import 'package:my_flutter/OC-brdging/OC-brdging.dart';
import 'package:my_flutter/TokenManager/tokenManager.dart';
import 'package:my_flutter/http_netWork/http_loading.dart';
import 'http_netWork/http_requestv2.dart';
import 'dart:io';
import 'package:my_flutter/OC-brdging/OC-brdging.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/services.dart';

var roleArray = [];
String selectID = "";

class RoleChangeVC extends StatelessWidget {
  const RoleChangeVC({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('角色切换v2'),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: SetUpUI(),
    );
  }
}

class SetUpUI extends StatefulWidget {
  SetUpUI({Key? key}) : super(key: key);

  @override
  _SetUpUIState createState() => _SetUpUIState();
}

class _SetUpUIState extends State<SetUpUI> {
  //获取角色列表
  @override
  void initState() {
    super.initState();
    MethodChannel platform = MethodChannel(OCPull_FlutterBrdgingDYL);
    platform.setMethodCallHandler((MethodCall call) {
      if (call.method == refreshUsermanager) {
        dynamic arguments = call.arguments;
        UserManager().userId = arguments["userId"];
        UserManager().teacherId = arguments["teacherId"];
        UserManager().nickName = arguments["nickName"];
        UserManager().phoneNumber = arguments['phoneNumber'];
        tokenManager().roleID = arguments["roleID"];
        tokenManager().access_token = arguments["token"];

        setState(() {
          selectID = tokenManager().roleID;
        });
        // Fluttertoast.showToast(
        //   msg:
        //       'MethodChannelroleID ====${tokenManager().roleID}phoneId===${UserManager().phoneId}',
        // );
        getRoleRequestList();
      }
      return Future<dynamic>.value();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getRoleRequestList() async {
    HttpDYL().getNetWork("/api/auth/queryroles",
        params: {"mobile": UserManager().phoneNumber}).then((result) {
      setState(() {
        roleArray = result.data;
      });
    });
  }

  //更换角色
  roleUpdataLogin(roleId) async {
    LoadingUtils.show;
    HttpDYL().postNetWorkNomodel("/connect/token", params: {
      'grant_type': "password",
      'scope': "Dayulong offline_access",
      'client_id': "Dayulong_App",
      'client_secret': "Dayulong88888888",
      'username': UserManager().phoneId,
      // 'password': '',
      'loginType': "9",
      'code': tokenManager().access_token,
      'roleId': roleId,
      'loginFrom': "housekeeperApp" ////    对学生登录进行拦截
    }).then((result) {
      if (result?.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "切换成功",
        );
        Map userTokenData = result?.data;
        userTokenData['roleId'] = roleId;
        pushApp_Brdging(appRoleRefreshToken, params: userTokenData);
        setState(() {
          selectID = roleId;
        });
      } else {
        Fluttertoast.showToast(
          msg: "操作失败",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Image.asset(
            'images/roleChangeIcon.png',
            width: 76,
            height: 48,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text('你的角色',
              style: (TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: roleArray.length,
            itemBuilder: (BuildContext context, int index) {
              Map teacherDict = roleArray[index];
              String nameStr = teacherDict["name"];
              String idStr = teacherDict["id"];

              // bool isSelect = false;
              Color textColor = Color.fromARGB(255, 34, 34, 34);
              Color backColor = Color.fromARGB(255, 245, 245, 245);
              if (selectID == idStr) {
                // isSelect = true;
                textColor = Colors.white;
                backColor = Color.fromARGB(255, 36, 68, 67);
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 375,
                    height: 45,
                    child: GestureDetector(
                        onTap: () {
                          // Fluttertoast.showToast(
                          //   msg: 'selectID===$selectID idStr===$idStr}',
                          // );
                          if (roleArray.length > 1) {
                            _showDialog(context, nameStr, idStr);
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: BorderRadius.circular(4)),
                            width: 375,
                            height: 45,
                            child: Center(
                              child: Text(
                                nameStr,
                                style: TextStyle(
                                  color: textColor,
                                  // height: 10,
                                ),
                              ),
                            ))),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  _showDialog(widgetContext, title, selectID) {
    showCupertinoDialog(
      context: widgetContext,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Text('您将更换角色为:$title'),
            actions: [
              CupertinoDialogAction(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text('确定'),
                isDestructiveAction: true,
                onPressed: () {
                  roleUpdataLogin(selectID);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
          // } else if (Platform.isAndroid) {
        } else {
          return AlertDialog(
            title: const Text(
              '提示',
              textAlign: TextAlign.center,
            ),
            titlePadding: const EdgeInsets.all(10),
            titleTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text('您将更换角色为:$title'),
                  // Text('内容2'),
                ],
              ),
            ),
            contentTextStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('取消'),
              ),
              ElevatedButton(
                onPressed: () {
                  roleUpdataLogin(selectID);
                  Navigator.of(context).pop();
                },
                child: const Text('确定'),
              ),
            ],
            actionsPadding: const EdgeInsets.all(10),
            actionsOverflowButtonSpacing: 10,
            backgroundColor: Colors.white,
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }
      },
    );
  }
}
