import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter/%E8%A7%92%E8%89%B2%E5%8F%98%E6%9B%B4/RoleChangeVC.dart';
import 'package:my_flutter/http_netWork/http_loading.dart';
import '../DYL_userManager.dart';
import '../http_netWork/http_requestv2.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: non_constant_identifier_names
Color TextNormalColor = const Color.fromARGB(255, 34, 34, 34);
// ignore: non_constant_identifier_names
Color LineWhiteNormalColor =
    const Color.fromARGB(255, 239, 239, 239); //白主题 分割线颜色
// ignore: non_constant_identifier_names
Color MainGreenColor = const Color.fromARGB(255, 0, 0, 0);

// 选择要退出的店铺id
List idArray = [];

String selectID = "";
//编辑退出店铺的ID
String selectEditID = "";
// 角色所管理的店铺列表
List roleShopArray = [];

// class moreView extends StatefulWidget {
//   moreView({Key? key}) : super(key: key);

//   @override
//   State<moreView> createState() => _moreViewState();
// }

// class _moreViewState extends State<moreView> {
//   @override
//   Widget build(BuildContext context) {
//     roleShopArray = [
//       {
//         'id': '111',
//         'name': '张三',
//         'isSelect': false,
//         'children': [
//           {'id': '122', 'name': '二级', 'isSelect': false}
//         ]
//       },
//       {
//         'id': '222',
//         'name': '张四',
//         'isSelect': false,
//         'children': [
//           {'id': '222', 'name': '二级', 'isSelect': false},
//           {'id': '233', 'name': '二级2', 'isSelect': false}
//         ]
//       },
//       {'id': '333', 'name': '李五', 'isSelect': false, 'children': []}
//     ];
//     return _showEditMoreView('title', context);
//   }

// ignore: must_be_immutable
class ScaffoldBottomSheetPage extends StatefulWidget {
  List baseArray;
  String titleStr;
  String roleID;

  dynamic callback;

  ScaffoldBottomSheetPage(
      {Key? key,
      required this.titleStr,
      required this.baseArray,
      required this.roleID,
      required this.callback})
      : super(key: key);
  @override
  _ScaffoldBottomSheetPageState createState() =>
      _ScaffoldBottomSheetPageState();
}

class _ScaffoldBottomSheetPageState extends State<ScaffoldBottomSheetPage> {
  @override
  // List<dynamic> roleShopArray = [
  //   {
  //     'id': '111',
  //     'name': '张三',
  //     'isSelect': false,
  //     'children': [
  //       {'id': '122', 'name': '二级', 'isSelect': false}
  //     ]
  //   },
  //   {
  //     'id': '222',
  //     'name': '张四',
  //     'isSelect': false,
  //     'children': [
  //       {'id': '222', 'name': '二级', 'isSelect': false},
  //       {'id': '233', 'name': '二级2', 'isSelect': false}
  //     ]
  //   },
  //   {'id': '333', 'name': '李五', 'isSelect': false, 'children': []}
  // ];

  Widget build(BuildContext context) {
    selectEditID = widget.roleID;
    roleShopArray = widget.baseArray;
    return _showEditMoreView(widget.titleStr, context);
  }

  Widget _buildTitleWidget() {
    return Container(
      child: Text('所选角色：${widget.titleStr}'),
    );
  }

//获取角色列表
// getRoleRequestList() async {
//   HttpDYL().getNetWork("/api/auth/queryroles",
//       params: {"mobile": UserManager().phoneNumber}).then((result) {
//     print(222);
//     roleArray = result.data;
//   });
// }
//退出店铺
  postQuitUnionsRquest() async {
    widget.callback;
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
    print(idArray);
    LoadingUtils.show;
    HttpDYL().postNetWork("/phone/User/QuitUnion", params: {
      "roleId": selectEditID,
      'unionIdList': idArray
    }).then((result) {
      LoadingUtils.dismiss();
      idArray = [];
      selectEditID = '';
      if (result.code == 200) {
        // getRoleRequestList();
        // EventBus eventBus = EventBus();
        // eventBus.fire(getRoleRequestList());

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

  Widget _buildItemWidget(Map<String, dynamic> value) {
    // List<dynamic> shopList = value["children"];

    // List<Widget> shopWigate = [];
    // for (var i = 0; i < shopList.length; i++) {
    //   Map shopModel = shopList[i];
    //   Widget shopW;
    //   String cityName = shopModel['name'];
    //   shopW = InkWell(
    //       onTap: () {},
    //       child: Column(children: <Widget>[
    //         SizedBox(
    //           child: Row(
    //             children: [
    //               const SizedBox(
    //                 width: 40,
    //                 child: Center(
    //                   child: Text(
    //                     '·',
    //                     style: TextStyle(fontSize: 40, color: Colors.cyan),
    //                   ),
    //                 ),
    //               ),
    //               Expanded(
    //                 child: InkWell(
    //                   onTap: () {
    //                     //
    //                     Map cityMapone = value;
    //                     //二级数据列表
    //                     List shopListList = cityMapone['children'];
    //                     //当前点击的cell
    //                     Map shopModelone = shopListList[i];

    //                     setState(
    //                       () {
    //                         shopModelone['isSelect'] =
    //                             !shopModelone['isSelect'];
    //                       },
    //                     );

    //                     // 如果是取消状态，则把一级数据改为no
    //                     if (!shopModelone['isSelect']) {
    //                       setState(
    //                         () {
    //                           cityMapone['isSelect'] = false;
    //                         },
    //                       );
    //                     } else {
    //                       //如果所有二级都是选中状态，则把一级也改为yes
    //                       int selectCount = 0;
    //                       for (Map shopForMode in shopListList) {
    //                         if (shopForMode['isSelect']) {
    //                           selectCount++;
    //                         }
    //                       }
    //                       if (selectCount >= shopListList.length) {
    //                         setState(
    //                           () {
    //                             cityMapone['isSelect'] = true;
    //                           },
    //                         );
    //                       }
    //                     }
    //                     print(roleShopArray);
    //                   },
    //                   child: Container(
    //                     height: 45,
    //                     decoration: BoxDecoration(
    //                         color: const Color.fromARGB(255, 245, 245, 245),
    //                         borderRadius: BorderRadius.circular(4)),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Container(
    //                           padding: const EdgeInsets.only(left: 15),
    //                           child: Text(cityName,
    //                               style: const TextStyle(
    //                                   // backgroundColor: Colors.red,
    //                                   )),
    //                         ),
    //                         Container(
    //                             padding: const EdgeInsets.symmetric(
    //                                 horizontal: 10, vertical: 10),
    //                             child: Image.asset(
    //                               shopModel['isSelect']
    //                                   ? 'images/roleSelect_S.png'
    //                                   : 'images/roleSelect_D.png',
    //                               height: 15,
    //                               width: 15,
    //                             ))
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ]));
    //   shopWigate.add(shopW);
    // }

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          bool cityIsSelect = value['isSelect'];
          setState(() {
            value['isSelect'] = !cityIsSelect;
          });

          // List shopList = value['children'];
          // for (Map shopModel in shopList) {
          //   setState(() {
          //     shopModel['isSelect'] = !cityIsSelect;
          //   });
          // }
        },
        child: Column(children: [
          Container(
              height: 45,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(value["name"],
                          style: TextStyle(color: TextNormalColor)),
                    ),
                    InkWell(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Image.asset(
                              value['isSelect']
                                  ? 'images/roleSelect_S.png'
                                  : 'images/roleSelect_D.png',
                              height: 15,
                              width: 15,
                            ))),
                  ])),
          // shopList.isEmpty
          // ? Container()
          // : Column(
          // children: shopWigate,
          // ),
        ]),
      ),
    );
  }

  //内容
  Widget _buildContentWidget() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildItemWidget(roleShopArray[index]);
        },
        itemCount: roleShopArray.length,
      ),
    );
  }

  //操作按钮

  Widget _buildOptionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //取消
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              // SetUpUI().getRoleRequestListUpdata();
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: lineWhiteNormalColor, width: 1)),
              child: const Center(
                child: Text(
                  '取消',
                  style: TextStyle(color: Color.fromRGBO(34, 34, 34, 1)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        //退出店铺
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              postQuitUnionsRquest();
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MainGreenColor,
                borderRadius: BorderRadius.circular(4),
                // border: Border.all(color: Colors.yellow, width: 1)
              ),
              child: const Center(
                child: Text(
                  '退出店铺',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showEditMoreView(title, context) {
    return SafeArea(
      bottom: false,
      child: Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 34),
          height: 350,
          color: Colors.white,
          child: Column(
            children: [
              //title
              _buildTitleWidget(),
              const SizedBox(height: 15),
              //内容
              _buildContentWidget(),
              const SizedBox(height: 15),
              //操作按钮
              _buildOptionWidget(),
            ],
          )),
    );
  }
}



// _showEditMoreView(title, context) {
//   return Container(
//       padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
//       // width: 414,
//       height: 300,
//       color: Colors.white,
//       child: Column(
//         children: [
//           SizedBox(
//             height: 300 - 100,
//             child: Column(
//               children: [
//                 Text('所选角色：$title',
//                     style: const TextStyle(
//                         color: Color.fromARGB(255, 34, 34, 34),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16)),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   // physics: const NeverScrollableScrollPhysics(),
//                   itemCount: roleShopArray.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     Map cityMap = roleShopArray[index];
//                     String cityName = cityMap['name'];
//                     List shopList = cityMap['children'];

//                     List<Widget> shopWigate = [];
//                     for (var i = 0; i < shopList.length; i++) {
//                       Map shopModel = shopList[i];
//                       Widget shopW;
//                       String cityName = shopModel['name'];
//                       shopW = InkWell(
//                           onTap: () {},
//                           child: Column(children: <Widget>[
//                             SizedBox(
//                               // height: 45,
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 // alignment: Alignment.centerLeft,
//                                 children: [
//                                   const SizedBox(
//                                     width: 40,
//                                     child: Center(
//                                       child: Text(
//                                         '·',
//                                         style: TextStyle(
//                                             fontSize: 40, color: Colors.cyan),
//                                       ),
//                                     ),
//                                   ),
//                                   StatefulBuilder(
//                                     builder: (BuildContext context, setState) {
//                                       return InkWell(
//                                         onTap: () {
//                                           //
//                                           Map cityMapone = roleShopArray[index];
//                                           //二级数据列表
//                                           List shopListList =
//                                               cityMapone['children'];
//                                           //当前点击的cell
//                                           Map shopModelone = shopListList[i];

//                                           setState(
//                                             () {
//                                               shopModelone['isSelect'] =
//                                                   !shopModelone['isSelect'];
//                                             },
//                                           );

//                                           // 如果是取消状态，则把一级数据改为no
//                                           if (!shopModelone['isSelect']) {
//                                             setState(
//                                               () {
//                                                 cityMapone['isSelect'] = false;
//                                               },
//                                             );
//                                           } else {
//                                             //如果所有二级都是选中状态，则把一级也改为yes
//                                             int selectCount = 0;
//                                             for (Map shopForMode
//                                                 in shopListList) {
//                                               if (shopForMode['isSelect']) {
//                                                 selectCount++;
//                                               }
//                                             }
//                                             if (selectCount >=
//                                                 shopListList.length) {
//                                               setState(
//                                                 () {
//                                                   cityMapone['isSelect'] = true;
//                                                 },
//                                               );
//                                             }
//                                           }
//                                           print(roleShopArray);
//                                         },
//                                         child: Container(
//                                           width: window.physicalSize.width /
//                                                   window.devicePixelRatio -
//                                               40 -
//                                               30,
//                                           height: 45,
//                                           decoration: BoxDecoration(
//                                               color: const Color.fromARGB(
//                                                   255, 245, 245, 245),
//                                               borderRadius:
//                                                   BorderRadius.circular(4)),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 15),
//                                                 child: Text(cityName,
//                                                     style: const TextStyle(
//                                                         // backgroundColor: Colors.red,
//                                                         )),
//                                               ),
//                                               Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 10),
//                                                 child: Image.asset(
//                                                   roleShopArray[index]
//                                                               ['children'][i]
//                                                           ['isSelect']
//                                                       ? 'images/roleSelect_S.png'
//                                                       : 'images/roleSelect_D.png',
//                                                   width: 15,
//                                                   height: 15,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ]));
//                       shopWigate.add(shopW);
//                     }
//                     return Column(
//                       children: [
//                         const SizedBox(height: 15),
//                         StatefulBuilder(
//                             builder: (BuildContext context, setState) {
//                           return GestureDetector(
//                               onTap: () {
//                                 //选择
//                                 setState(() {
//                                   Map cityMapone = roleShopArray[index];

//                                   cityMapone['isSelect'] =
//                                       !cityMapone['isSelect'];
//                                   List shopList = cityMapone['children'];

//                                   for (Map shopItem in shopList) {
//                                     shopItem['isSelect'] =
//                                         cityMapone['isSelect'];
//                                   }
//                                   print(roleShopArray);
//                                   // List.generate(
//                                   //     shopList.length,
//                                   //     (index) => shopList[index]
//                                   //             ['isSelect'] =
//                                   //         cityMapone['isSelect']);
//                                 });
//                               },
//                               child: Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                     color: const Color.fromARGB(
//                                         255, 245, 245, 245),
//                                     borderRadius: BorderRadius.circular(4)),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   // alignment: Alignment.centerLeft,
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.only(left: 15),
//                                       child: Text(cityName,
//                                           style: TextStyle(
//                                               // backgroundColor: Colors.red,
//                                               color: textNormalColor)),
//                                     ),
//                                     InkWell(
//                                         onTap: () {},
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 10, vertical: 10),
//                                           child: Image.asset(
//                                             roleShopArray[index]['isSelect']
//                                                 ? 'images/roleSelect_S.png'
//                                                 : 'images/roleSelect_D.png',
//                                             width: 15,
//                                             height: 15,
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                               ));
//                         }),
//                         Column(children: shopWigate),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 25),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Container(
//                   width: 127,
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4),
//                       border:
//                           Border.all(color: lineWhiteNormalColor, width: 1)),
//                   child: Center(
//                     child: Text(
//                       '取消',
//                       style: TextStyle(color: textNormalColor),
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   postQuitUnionsRquest();
//                   Navigator.of(context).pop();
//                 },
//                 child: Container(
//                     width: window.physicalSize.width / window.devicePixelRatio -
//                         127 -
//                         30 -
//                         30,
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4),
//                       color: MainGreenColor,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         '退出店铺',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     )),
//               )
//             ],
//           )
//         ],
//       ));
// }
