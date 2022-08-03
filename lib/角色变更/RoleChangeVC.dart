import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/%E8%A7%92%E8%89%B2%E5%8F%98%E6%9B%B4/RoleShopListModel.dart';
import 'package:my_flutter/DYL_userManager.dart';
import 'package:my_flutter/OC-brdging/OC-brdging.dart';
import 'package:my_flutter/TokenManager/tokenManager.dart';
import 'package:my_flutter/http_netWork/http_loading.dart';
import '../http_netWork/http_requestv2.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/services.dart'; // ignore: non_constant_identifier_names

Color textNormalColor = const Color.fromARGB(255, 34, 34, 34);
Color lineWhiteNormalColor =
    const Color.fromARGB(255, 239, 239, 239); //白主题 分割线颜色
// ignore: non_constant_identifier_names
Color MainGreenColor = const Color.fromARGB(255, 0, 0, 0);
//角色列表
var roleArray = [];
// 角色所管理的店铺列表
List roleShopArray = [];
// 选择要退出的店铺id
List idArray = [];

String selectID = "";
//编辑退出店铺的ID
String selectEditID = "";

class RoleChangeVC extends StatefulWidget {
  RoleChangeVC({Key? key}) : super(key: key);

  @override
  State<RoleChangeVC> createState() => _RoleChangeVCState();
}

class _RoleChangeVCState extends State<RoleChangeVC> {
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

//获取角色列表
  getRoleRequestList() async {
    print(1111);
    HttpDYL().getNetWork("/api/auth/queryroles",
        params: {"mobile": UserManager().phoneNumber}).then((result) {
      print(222);
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
      'username': UserManager().phoneNumber,
      // 'password': '',
      'loginType': "9",
      'code': tokenManager().access_token,
      'roleId': roleId,
      'loginFrom': "housekeeperApp" ////    对学生登录进行拦截
    }).then((result) {
      LoadingUtils.dismiss();
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

// 获取角色所管理的店铺
  _getShopList(editSelectRoleId, titleStr) async {
    print(tokenManager().access_token);
    LoadingUtils.show;
    HttpDYL().getNetWork("/phone/User/GetUserUnionList", params: {
      'roleId': editSelectRoleId,
    }).then((result) {
      if (result.code == 200) {
        List copyArray = result.data;
        for (Map cityMap in copyArray) {
          cityMap.putIfAbsent('isSelect', () => false);
        }
        roleShopArray = copyArray;
        showModalBottomSheet(
            context: context,
            builder: (_) => ScaffoldBottomSheetPage(
                  titleStr: titleStr,
                  baseArray: copyArray,
                  roleID: selectEditID,
                  callback: getRoleRequestList(),
                ));
      } else {
        Fluttertoast.showToast(
          msg: result.msg,
        );
      }
    });
  }

//退出店铺
  postQuitUnionsRquest() async {
    for (Map cityMap in roleShopArray) {
      if (cityMap['isSelect']) {
        idArray.add(cityMap['id']);
      }
      // for (Map shopMap in cityMap['children']) {
      //   if (shopMap['isSelect']) {
      //     idArray.add(shopMap['id']);
      //   }
      // }
    }

    HttpDYL().postNetWork("/phone/User/QuitUnion", params: {
      "roleId": selectEditID,
      'unionIdList': idArray
    }).then((result) {
      idArray = [];
      selectEditID = '';
      if (result.code == 200) {
        getRoleRequestList();
        Fluttertoast.showToast(
          msg: result.msg,
        );
      } else {
        Fluttertoast.showToast(
          msg: result.msg,
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
                                    selectEditID = idStr;
                                    // showModalBottomSheet(
                                    //     context: context,
                                    //     builder: (_) =>
                                    //         ScaffoldBottomSheetPage());
                                    // showModelBottomSheet(
                                    //     context: context,
                                    //     builder: (_) => moreView());
                                    _getShopList(idStr, nameStr);
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
            // width: 414,
            height: 300,
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 300 - 100,
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
                            String cityName = cityMap['name'];
                            List shopList = cityMap['children'];

                            List<Widget> shopWigate = [];
                            for (var i = 0; i < shopList.length; i++) {
                              Map shopModel = shopList[i];
                              Widget shopW;
                              String cityName = shopModel['name'];
                              shopW = InkWell(
                                  onTap: () {},
                                  child: Column(children: <Widget>[
                                    SizedBox(
                                      // height: 45,
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        // alignment: Alignment.centerLeft,
                                        children: [
                                          const SizedBox(
                                            width: 40,
                                            child: Center(
                                              child: Text(
                                                '·',
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.cyan),
                                              ),
                                            ),
                                          ),
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return InkWell(
                                                onTap: () {
                                                  //
                                                  Map cityMapone =
                                                      roleShopArray[index];
                                                  //二级数据列表
                                                  List shopListList =
                                                      cityMapone['children'];
                                                  //当前点击的cell
                                                  Map shopModelone =
                                                      shopListList[i];

                                                  setState(
                                                    () {
                                                      shopModelone['isSelect'] =
                                                          !shopModelone[
                                                              'isSelect'];
                                                    },
                                                  );

                                                  // 如果是取消状态，则把一级数据改为no
                                                  if (!shopModelone[
                                                      'isSelect']) {
                                                    setState(
                                                      () {
                                                        cityMapone['isSelect'] =
                                                            false;
                                                      },
                                                    );
                                                  } else {
                                                    //如果所有二级都是选中状态，则把一级也改为yes
                                                    int selectCount = 0;
                                                    for (Map shopForMode
                                                        in shopListList) {
                                                      if (shopForMode[
                                                          'isSelect']) {
                                                        selectCount++;
                                                      }
                                                    }
                                                    if (selectCount >=
                                                        shopListList.length) {
                                                      setState(
                                                        () {
                                                          cityMapone[
                                                                  'isSelect'] =
                                                              true;
                                                        },
                                                      );
                                                    }
                                                  }
                                                  print(roleShopArray);
                                                },
                                                child: Container(
                                                  width: window.physicalSize
                                                              .width /
                                                          window
                                                              .devicePixelRatio -
                                                      40 -
                                                      30,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              245,
                                                              245,
                                                              245),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Text(cityName,
                                                            style: const TextStyle(
                                                                // backgroundColor: Colors.red,
                                                                )),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Image.asset(
                                                          roleShopArray[index][
                                                                      'children']
                                                                  [
                                                                  i]['isSelect']
                                                              ? 'images/roleSelect_S.png'
                                                              : 'images/roleSelect_D.png',
                                                          width: 15,
                                                          height: 15,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]));
                              shopWigate.add(shopW);
                            }
                            return Column(
                              children: [
                                const SizedBox(height: 15),
                                StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                  return GestureDetector(
                                      onTap: () {
                                        //选择
                                        setState(() {
                                          Map cityMapone = roleShopArray[index];

                                          cityMapone['isSelect'] =
                                              !cityMapone['isSelect'];
                                          List shopList =
                                              cityMapone['children'];

                                          for (Map shopItem in shopList) {
                                            shopItem['isSelect'] =
                                                cityMapone['isSelect'];
                                          }
                                          print(roleShopArray);
                                          // List.generate(
                                          //     shopList.length,
                                          //     (index) => shopList[index]
                                          //             ['isSelect'] =
                                          //         cityMapone['isSelect']);
                                        });
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 245, 245, 245),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // alignment: Alignment.centerLeft,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(cityName,
                                                  style: TextStyle(
                                                      // backgroundColor: Colors.red,
                                                      color: textNormalColor)),
                                            ),
                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Image.asset(
                                                    roleShopArray[index]
                                                            ['isSelect']
                                                        ? 'images/roleSelect_S.png'
                                                        : 'images/roleSelect_D.png',
                                                    width: 15,
                                                    height: 15,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ));
                                }),
                                Column(children: shopWigate),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 127,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: lineWhiteNormalColor, width: 1)),
                          child: Center(
                            child: Text(
                              '取消',
                              style: TextStyle(color: textNormalColor),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          postQuitUnionsRquest();
                          Navigator.of(context).pop();
                        },
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
