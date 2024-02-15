import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeView extends StatefulWidget {
  const YoutubeView({super.key, required this.url});

  final String url;

  @override
  State<YoutubeView> createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<YoutubeView> {
  late WebViewController _controller;
  @override
  void initState() {
    String ytID =
        widget.url.split("https://www.youtube.com/embed/")[1].split('?')[0];
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            showToast("error loading trailer", position: ToastPosition.bottom);
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://movee.vercel.app/iframe/$ytID"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 3,
      child: WebViewWidget(controller: _controller),
    );
  }
}
