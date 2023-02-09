
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DigestWebScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _WebScreenState();
}

class _WebScreenState extends State<DigestWebScreen> {
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
          "Дайджест Академии",
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
            initialUrl: "https://rosatom-academy.ru/documents/751/%D0%94%D0%B0%D0%B9%D0%B4%D0%B6%D0%B5%D1%81%D1%82_%D0%90%D0%BA%D0%B0%D0%B4%D0%B5%D0%BC%D0%B8%D0%B8_%D0%A0%D0%BE%D1%81%D0%B0%D1%82%D0%BE%D0%BC%D0%B0_24_2020.pdf",
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
