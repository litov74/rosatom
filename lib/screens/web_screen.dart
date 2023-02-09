
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  bool _loading;

  @override
  void initState() {
    _loading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Об Академии",
          style: TextStyle(color: Colors.black, fontFamily: "CeraPro-Medium"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF025EA1)),
        elevation: 1,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: "https://rosatom-academy.ru/ob-akademii/",
            onPageFinished: (String _) {
              setState(() {
                _loading = false;
              });
            },
          ),
          _loading ? Center(child: CircularProgressIndicator()) : Container()
        ],
      ),
    );
  }
}
