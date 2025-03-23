import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailScreen extends StatefulWidget {
  final String url;

  const DetailScreen({Key? key, required this.url}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController();

    // Validate the URL before loading
    if (widget.url.isNotEmpty &&
        (widget.url.startsWith("http://") ||
            widget.url.startsWith("https://"))) {
      _controller.loadRequest(Uri.parse(widget.url));
    } else {
      debugPrint("Invalid URL: ${widget.url}");
      // Show an error message or redirect to a default page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Detail")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
