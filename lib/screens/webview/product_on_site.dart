import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductOnSiteState extends StatefulWidget {
  final Uri url;

  ProductOnSiteState(this.url, {super.key});

  @override
  State<ProductOnSiteState> createState() => _ProductOnSiteStateState();
}

class _ProductOnSiteStateState extends State<ProductOnSiteState> {
  final cont = WebViewController();
  bool loading = true;
  int progress = 0;

  @override
  void initState() {
    cont.setJavaScriptMode(JavaScriptMode.unrestricted);
    cont.setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress){
            setState(() {
              this.progress = progress;
              loading = progress < 90;
            });
        },
        onWebResourceError: (WebResourceError error){
          log("Error: in webresource, ${error}");
        }
    ));
    cont.loadRequest(widget.url);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(),
            const SizedBox(height: 10),
            Text("Loading...($progress%)"),
          ],
        ),
      ) : SafeArea(child: WebViewWidget(controller: cont)),
    );
  }
}
