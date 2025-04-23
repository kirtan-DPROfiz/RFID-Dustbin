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
//--------------------------------//
/*

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
*/

//-------------------------//
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Add these imports for platform-specific implementations
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebView({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Platform-specific initialization
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() => _isLoading = true);
        },
        onPageFinished: (url) {
          setState(() => _isLoading = false);
          _checkForPaymentSuccess(url);
        },
        onWebResourceError: (error) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading payment page: ${error.description}')),
          );
        },
      ))
      ..loadRequest(Uri.parse(widget.paymentUrl));

    // Enable hybrid composition for Android
    if (_controller.platform is AndroidWebViewController) {
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  void _checkForPaymentSuccess(String url) {
    // Check both URL and page content for success message
    _controller.runJavaScriptReturningResult("document.body.innerText").then((content) {
      if (content.toString().contains("Payment successful! Your subscription is activated.") ||
          url.contains("payment_success")) {
        Navigator.of(context).pushReplacementNamed('/customLogin');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Payment"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
