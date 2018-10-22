import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/app_route.dart';
import 'package:flutter_login/nav_to_page.dart';

void main() {
  router.define('home/:data', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    print(params);
    return new NavToPage(params['data'][0]);
  }));

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Color(0xFFE94444),
      ),
      home: new MyHomePage(title: '身份验证'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _phonecontroller = new TextEditingController();
  final TextEditingController _codecontroller = new TextEditingController();
  final TextEditingController _pwdcontroller = new TextEditingController();
  bool _isFavorited = true;
  bool _isdownTime = false;
  bool _isphoneNumTrue = false;
  int _seconds = 0;
  Timer _timer;
  String _verifyStr = "获取验证码";

  void showPwd() {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }


  //倒计时
  _startTimer() {
    if (_isdownTime == false) {
      _isdownTime = true;
      _seconds = 10;
      _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        if (_seconds == 0) {
          _cancelTimer();
          _isdownTime = false;
          return;
        }
        _seconds--;
        _verifyStr = '$_seconds(s)';
        setState(() {});
        if (_seconds == 0) {
          _verifyStr = '重新发送';
        }
      });
    }
  }

  //取消倒计时
  _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "身份验证",
          style: TextStyle(fontSize: 16.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 50.0),
                    child: Image.asset(
                      "images/picture.png",
                      width: 83.0,
                      height: 95.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "为了让您更好地使用群聊功能",
                      style:
                          TextStyle(color: Color(0xFFE94444), fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "请补充个人信息",
                      style:
                          TextStyle(color: Color(0xFFE94444), fontSize: 16.0),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 60.0, right: 60.0, top: 50.0),
                    child: Row(
                      children: <Widget>[
                        Text("+86"),
                        Container(
                          margin: EdgeInsetsDirectional.only(start: 10),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _phonecontroller,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: '手机号',
                              hintStyle: TextStyle(
                                color: Color(0xFF9a9a9a),
                                fontSize: 14.0,
                              ),
                            ),
                            onChanged: (text) {
                              //内容改变的回调
                              if (text.length == 11) {
                                setState(() {
                                  _isphoneNumTrue = true;
                                });
                              } else {
                                setState(() {
                                  _isphoneNumTrue = false;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Divider(
                      height: 0.0,
                      color: Color(0xFF999999),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _codecontroller,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: '短信验证码',
                              hintStyle: TextStyle(
                                color: Color(0xFF9a9a9a),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
//                      OutlineButton(
//                        onPressed: () {},
//                        child: new Text(
//                          '获取验证码',
//                          style: new TextStyle(
//                            color: Theme.of(context).primaryColor,
//                          ),
//                        ),
//                        borderSide: new BorderSide(
//                          color: Theme.of(context).primaryColor,
//                        ),
//                      ),

                        GestureDetector(
                          onTap: _startTimer,
                          child: Material(
                            color: Colors.white,
                            shape: new RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.0,
                                color: _isphoneNumTrue
                                    ? Color(0xFFe94444)
                                    : Color(0xFF999999),
                              ),
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            child: new Container(
                              width: 90.0,
                              height: 30.0,
                              child: Center(
                                child: new Text(
                                  _verifyStr,
                                  style: new TextStyle(
                                    fontSize: 12.0,
                                    color: _isphoneNumTrue
                                        ? Color(0xFFe94444)
                                        : Color(0xFF999999),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 180.0),
                    child: Divider(
                      height: 0.0,
                      color: Color(0xFF999999),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _pwdcontroller,
                            obscureText: _isFavorited, //是否
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: '设置密码(6-12位数字字母组合)',
                              hintStyle: TextStyle(
                                color: Color(0xFF9a9a9a),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: showPwd,
                          icon: (_isFavorited
                              ? ImageIcon(AssetImage("images/cb_pwd_n.png"))
                              : ImageIcon(AssetImage("images/cb_pwd_s.png"))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Divider(
                      height: 0.0,
                      color: Color(0xFF999999),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: GestureDetector(
                      onTap: () {
//                        var bodyJson = '{"user":1281,"pass":3041}';
                        var phoneNum = _phonecontroller.text;
                        router.navigateTo(context, '/home/$phoneNum');
                      },
                      child: Material(
                        color: Color(0xFFCCCCCC),
                        shape: new RoundedRectangleBorder(
//                      side: const BorderSide(
//                        width: 1.0,
//                        color: Color(0xFF999999),
//                      ),
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        child: new Container(
                          width: 250.0,
                          height: 40.0,
                          child: Center(
                            child: new Text(
                              '下一步',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Color(0xFFFFFFFF)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
