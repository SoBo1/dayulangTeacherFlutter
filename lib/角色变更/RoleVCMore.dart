import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/DYL_userManager.dart';
import 'package:my_flutter/OC-brdging/OC-brdging.dart';
import 'package:my_flutter/TokenManager/tokenManager.dart';
import 'package:my_flutter/http_netWork/http_loading.dart';
import '../http_netWork/http_requestv2.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/services.dart';

// ignore: non_constant_identifier_names
Color TextNormalColor = const Color.fromARGB(255, 34, 34, 34);
// ignore: non_constant_identifier_names
Color LineWhiteNormalColor =
    const Color.fromARGB(255, 239, 239, 239); //白主题 分割线颜色
// ignore: non_constant_identifier_names
Color MainGreenColor = const Color.fromARGB(255, 0, 0, 0);
//角色列表
var roleArray = [];
// 角色所管理的店铺列表
List roleShopArray = [];
String selectID = "";

class RoleVCModre extends StatelessWidget {
  const RoleVCModre({Key? key}) : super(key: key);
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
    getRoleRequestList();
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
    HttpDYL().postNetWork("/connect/token", params: {
      'grant_type': "password",
      'scope': "Dayulong offline_access",
      'client_id': "Dayulong_App",
      'client_secret': "Dayulong88888888",
      'username': UserManager().phoneNumber,
      // 'password': '',
      'loginType': "9",
      // 'code': tokenManager().access_token,
      'roleId': roleId,
      'loginFrom': "housekeeperApp" ////    对学生登录进行拦截
    }).then((result) {
      if (result.code == 200) {
        Fluttertoast.showToast(
          msg: "切换成功",
        );
        Map userTokenData = result.data;
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

// 获取角色所管理的店铺
  _getShopList(editSelectRoleId) async {
    LoadingUtils.show;
    HttpDYL().getNetWork("/phone/User/GetUserUnionList", params: {
      'grant_type': "password",
      'scope': "Dayulong offline_access",
      'client_id': "Dayulong_App",
      'client_secret': "Dayulong88888888",
      'username': UserManager().phoneNumber,
      // 'password': '',
      'loginType': "9",
      'code': tokenManager().access_token,
      'roleId': editSelectRoleId,
      'loginFrom': "housekeeperApp" ////    对学生登录进行拦截
    }).then((result) {
      // if (result.code == 200) {
      // List copyArray = result.data;
      // for (Map cityMap in copyArray) {
      //   cityMap.putIfAbsent('isSelect', () => false);
      // List shopList = cityMap['children'];
      // shopList.add({'id': '111', 'name': '张三'});
      // for (Map shopMap in shopList) {
      //   shopMap.putIfAbsent('isSelect', () => false);
      // }
      // }
      List copyArray = [
        {
          'id': '111',
          'name': '张三',
          'isSelect': true,
          'children': [
            {'id': '111', 'name': '二级', 'isSelect': false}
          ]
        },
        {
          'id': '111',
          'name': '张四',
          'isSelect': true,
          'children': [
            {'id': '111', 'name': '二级', 'isSelect': false},
            {'id': '111', 'name': '二级2', 'isSelect': false}
          ]
        },
        {'id': '111', 'name': '李五', 'isSelect': true, 'children': []}
      ];
      setState(() {
        roleShopArray = copyArray;
      });
      // } else {
      //   Fluttertoast.showToast(
      //     msg: result.msg,
      //   );
      // }
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
              Color textColor = const Color.fromARGB(255, 34, 34, 34);
              Color backColor = const Color.fromARGB(255, 245, 245, 245);
              if (selectID == idStr) {
                // isSelect = true;
                textColor = Colors.white;
                backColor = const Color.fromARGB(255, 36, 68, 67);
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
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
                        // height: 45,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                                child: Container(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(nameStr,
                                  style: TextStyle(color: textColor)),
                            )),
                            Positioned(
                              right: 0,
                              child: InkWell(
                                  onTap: () {
                                    _showEditMoreView('$nameStr');
                                    _getShopList('$idStr');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Image.asset(
                                      'images/roleEditImage.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      )),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  _showEditMoreView(title) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            width: 414,
            height: 300,
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                children: [
                  Text('所选角色：$title',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 34, 34, 34),
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: roleShopArray.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map cityMap = roleShopArray[index];
                      String cityId = cityMap['id'];
                      String cityName = cityMap['name'];
                      bool isSelect = cityMap['isSelect'];
                      List shopList = cityMap['children'];

                      List<Widget> shopwidget = [];

                      return Column(
                        children: [
                          const SizedBox(height: 15),
                          GestureDetector(
                              onTap: () {
                                //选择
                                setState(() {
                                  isSelect = false; //!isSelect;
                                });
                              },
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 245, 245, 245),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(cityName,
                                          style: TextStyle(
                                              // backgroundColor: Colors.red,
                                              color: TextNormalColor)),
                                    ),
                                    InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Image.asset(
                                            isSelect
                                                ? 'images/roleSelect_S.png'
                                                : 'images/roleSelect_D.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                        )),
                                  ],
                                ),
                              )),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    children: [
                                      //内容
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 15),
                                        child: Text(
                                          '·',
                                          style: TextStyle(
                                              fontSize: 30, color: Colors.red),
                                        ),
                                      ),

                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 245, 245, 245),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //文字
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Text(cityName),
                                              ),
                                              //图片
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Image.asset(
                                                  isSelect
                                                      ? 'images/roleSelect_S.png'
                                                      : 'images/roleSelect_D.png',
                                                  width: 15,
                                                  height: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 127,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: LineWhiteNormalColor, width: 1)),
                          child: Center(
                            child: Text(
                              '取消',
                              style: TextStyle(color: TextNormalColor),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            width: window.physicalSize.width /
                                    window.devicePixelRatio -
                                127 -
                                30 -
                                30,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: MainGreenColor,
                            ),
                            child: const Center(
                              child: Text(
                                '退出店铺',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }

  _subCategoryList(List shopList) {
    List<Widget> shopwidget = [];
    for (Map shopModel in shopList) {
      String shopId = shopModel['id'];
      String shopName = shopModel['name'];
      bool isSelect = shopModel['isSelect'];
      shopwidget.add(Container(
        height: 45,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // alignment: Alignment.centerLeft,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(shopName,
                  style: TextStyle(
                      // backgroundColor: Colors.red,
                      color: TextNormalColor)),
            ),
            InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Image.asset(
                    isSelect
                        ? 'images/roleSelect_S.png'
                        : 'images/roleSelect_D.png',
                    width: 15,
                    height: 15,
                  ),
                )),
          ],
        ),
      ));
    }
    return shopwidget;
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
