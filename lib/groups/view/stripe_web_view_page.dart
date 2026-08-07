import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/log/app_utils.dart';
import '../../component/bottom_nav_bar/main_screen.dart';

class StripeWebViewPage extends StatefulWidget {
  final String checkoutUrl;

  const StripeWebViewPage({super.key, required this.checkoutUrl});
  @override
  State<StripeWebViewPage> createState() => _StripeWebViewPageState();
}
class _StripeWebViewPageState extends State<StripeWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });

            if (url.contains("success")) {
              Get.offAll(() => NavbarScreen());
              Utils.successSnackBar("Payment successful");
            } 
            else if (url.contains("cancel") || url.contains("failure")) {
              Get.back();
              Utils.errorSnackBar("Payment Status", "Payment was cancelled or failed.");
            }
          },
          onWebResourceError: (error) {
            debugPrint('WebView Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
        ],
      ),
    );
  }
}
