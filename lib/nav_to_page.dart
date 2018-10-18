import 'package:flutter/material.dart';

class NavToPage extends StatefulWidget {
  final String _result;

  NavToPage(this._result);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NavToPageState();
  }
}

class NavToPageState extends State<NavToPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "身份验证",
          style: TextStyle(fontSize: 16.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("号码:${widget._result}, 你是怎么进来的"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("images/default_photo.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
