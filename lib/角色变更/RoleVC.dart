import 'dart:ui';
import 'package:flutter/material.dart';

// import 'package:flutter_app/widget/ace_checkbox.dart';
class GroupListPage extends StatefulWidget {
  List<CategoryBean> listData = [
    CategoryBean(
        name: '特别关心',
        itemList: [
          SubCategoryBean(name: 'A', url: ''),
          SubCategoryBean(name: 'B', url: ''),
          SubCategoryBean(name: 'C', url: '')
        ],
        url: ''),
    CategoryBean(
        name: '分组一',
        itemList: [
          SubCategoryBean(name: 'D', url: ''),
          SubCategoryBean(name: 'E', url: ''),
          SubCategoryBean(name: 'F', url: '')
        ],
        url: ''),
    // CategoryBean(
    //     name: '分组二',
    //     itemList: [
    //       SubCategoryBean(name: 'G', url: ''),
    //       SubCategoryBean(name: 'H', url: ''),
    //       SubCategoryBean(name: 'I', url: '')
    //     ],
    //     url: ''),
    // CategoryBean(name: '分组三', itemList: [], url: ''),
    // CategoryBean(
    //     name: '分组四',
    //     itemList: [
    //       SubCategoryBean(name: 'J', url: ''),
    //       SubCategoryBean(name: 'K', url: ''),
    //       SubCategoryBean(name: 'L', url: '')
    //     ],
    //     url: ''),
    // CategoryBean(name: '分组五', itemList: [], url: ''),
    // CategoryBean(name: '分组六', itemList: [], url: '')
  ];

  @override
  State<StatefulWidget> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  @override
  Widget build(BuildContext context) {
    return
        // appBar: AppBar(title: Text('分组列表')),
        ListView.builder(
            itemCount: widget.listData.length,
            itemBuilder: (context, index) {
              return GroupItemWidget(widget.listData[index], widget.listData);
            });
  }
}

class GroupItemWidget extends StatefulWidget {
  final CategoryBean bean;
  final List<CategoryBean> listDataCopy;
  GroupItemWidget(this.bean, this.listDataCopy);

  @override
  State<StatefulWidget> createState() {
    return _GroupItemWidgetState();
  }
}

class _GroupItemWidgetState extends State<GroupItemWidget> {
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Column(children: <Widget>[
          // Divider(height: 8, color: Colors.white),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(children: <Widget>[
                Icon(_isExpand ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: Colors.blue),
                // _userIcon(false),
                const SizedBox(width: 5.0),
                Container(
                  width:
                      window.physicalSize.width / window.devicePixelRatio - 60,
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
                        child: Text(widget.bean.name,
                            style: const TextStyle(
                                // backgroundColor: Colors.red,
                                )),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              widget.bean._isChecked = !widget.bean._isChecked;
                              _rightCheckBox(widget.bean, 0, 0);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Image.asset(
                              widget.bean._isChecked
                                  ? 'images/roleSelect_S.png'
                                  : 'images/roleSelect_D.png',
                              width: 15,
                              height: 15,
                            ),
                          )),
                    ],
                  ),
                )

                // _rightCheckBox(widget.bean, 0)
              ])),
          _subCategoryList(widget.bean)
        ]),
        onTap: () {
          _isExpand = !_isExpand;
          setState(() {});
          if (widget.bean.name == '分组五' &&
              (widget.bean.itemList == null ||
                  widget.bean.itemList.length == 0)) {
            widget.bean.itemList = [
              SubCategoryBean(name: 'O', url: ''),
              SubCategoryBean(name: 'P', url: ''),
              SubCategoryBean(name: 'Q', url: '')
            ];
          }
        });
  }

  _subCategoryList(CategoryBean bean) {
    Widget _widget;
    if (!_isExpand || bean.itemList == null || bean.itemList.length == 0) {
      _widget = Container();
    } else {
      _widget = ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: bean.itemList.length,
          // ignore: avoid_types_as_parameter_names
          itemBuilder: (context, index) => Row(children: <Widget>[
                Flexible(child: _subCategoryItem(bean, index))
              ]));
    }
    return _widget;
  }

  // ignore: avoid_types_as_parameter_names
  _subCategoryItem(CategoryBean bean, itemIndex) {
    return InkWell(
        onTap: () {},
        child: Column(children: <Widget>[
          // Divider(height: 0.5, color: Colors.deepOrange),
          SizedBox(
            // height: 45,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: 60,
                  child: Center(
                    child: Text(
                      '·',
                      style: TextStyle(fontSize: 40, color: Colors.cyan),
                    ),
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          print(itemIndex);
                          print(bean.itemList[itemIndex]._isChecked);
                          print('star');
                          bean.itemList[itemIndex]._isChecked =
                              !bean.itemList[itemIndex]._isChecked;
                          _rightCheckBox(widget.bean, 1, itemIndex);
                          print('end');
                          print(itemIndex);
                          print(bean.itemList[itemIndex]._isChecked);
                        });
                      },
                      child: Container(
                        width: window.physicalSize.width /
                                window.devicePixelRatio -
                            60 -
                            15,
                        height: 45,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 245, 245, 245),
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(bean.itemList[itemIndex].name,
                                  style: TextStyle(
                                      // backgroundColor: Colors.red,
                                      )),
                            ),
                            //                StatefulBuilder(
                            // builder:
                            //     (BuildContext context, void Function(void Function()) setState){

                            //     }),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Image.asset(
                                bean._isChecked
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
  }

  _userIcon(isCircle) {
    double size = isCircle ? 40.0 : 45.0;
    return PhysicalModel(
        color: Colors.transparent,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Container(
            width: size,
            height: size,
            child: Image.asset(isCircle
                ? 'images/roleSelect_S.png'
                : 'images/roleSelect_D.png')));
  }

  _rightCheckBox(bean, type, subIndex) {
    print(bean.isChecked);
    bool _isChecked =
        type == 0 ? bean.isChecked : bean.itemList[subIndex].isChecked;
    return ACECheckbox(
        value: _isChecked,
        onChanged: (value) {
          setState(() => _isChecked = value);
          if (type == 0) {
            bean.isChecked = _isChecked;
            List.generate(bean.itemList.length,
                (index) => bean.itemList[index].isChecked = _isChecked);
          } else {
            bean.itemList[subIndex].isChecked = _isChecked;
            int checkedSize = 0;
            List.generate(bean.itemList.length, (index) {
              if (bean.itemList[index].isChecked == false) {
                bean.isChecked = false;
              } else {
                checkedSize += 1;
              }
              if (checkedSize == bean.itemList.length) {
                bean.isChecked = true;
              }
            });
          }
        });
  }
}

class ACECheckbox extends StatefulWidget {
  const ACECheckbox({Key? key, required this.value, required this.onChanged})
      : super(key: key);

// ignore: use_key_in_widget_constructors

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<ACECheckbox> createState() => _ACECheckboxState();
}

class _ACECheckboxState extends State<ACECheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CategoryBean {
  String name;
  String url;
  bool _isChecked = false;
  List<SubCategoryBean> itemList;

  bool get isChecked => _isChecked;

  set isChecked(bool value) => _isChecked = value;

  CategoryBean({required this.name, required this.url, required this.itemList});
}

class SubCategoryBean {
  String name;
  String url;
  bool _isChecked = false;

  SubCategoryBean({required this.name, required this.url});

  bool get isChecked => _isChecked;

  set isChecked(bool value) => _isChecked = value;
}
