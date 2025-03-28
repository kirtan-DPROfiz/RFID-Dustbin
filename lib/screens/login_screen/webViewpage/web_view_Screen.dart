/*import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' ;

class WebViewScreen extends StatefulWidget {
  final String url;
  final VoidCallback onPaymentSuccess;

  WebViewScreen({required this.url, required this.onPaymentSuccess});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) async {
          if (url.contains("payment_successful")) {  // Assuming the payment success page contains this URL part
            widget.onPaymentSuccess();
          }
        },
      ),
    );
  }
}*/

//-------------------------------------new----------------------------//
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebView({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl));

    // Listen for changes in the URL
    _controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (String url) {
        if (url.contains("Payment successful! Your subscription is activated.")) {
          // Navigate to the Custom Login Screen after successful payment
          Navigator.pushReplacementNamed(context, '/customLogin');
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Payment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
