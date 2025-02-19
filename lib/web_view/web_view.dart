import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {
  late String url;
  WebViewScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: "$url",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
