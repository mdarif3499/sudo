import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import '../../../config/route/app_routes.dart';
import '../../utils/log/app_utils.dart';

class WebviewScreen extends StatefulWidget {
  final String checkoutUrl;

  const WebviewScreen({super.key, required this.checkoutUrl});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params);

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      // Standard Mobile User-Agent
      ..setUserAgent("Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36")
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
            if (url.contains("Approved")) {
              Utils.successSnackBar("Verification Successful. Please Login.");
              Get.offAllNamed(AppRoutes.subscriptionScreen);
            } else if (url.contains("cancel") || url.contains("failure")) {
              Get.offAllNamed(AppRoutes.subscriptionScreen);
              Utils.errorSnackBar("KYC Status", "Verification was cancelled or failed.");
            }
          },
        ),
      );

    if (_controller.platform is AndroidWebViewController) {
      final androidController = _controller.platform as AndroidWebViewController;
      

      androidController.setOnPlatformPermissionRequest(
        (request) async {
          debugPrint("WebView requesting: ${request.types}");
          if (request.types.contains(WebViewPermissionResourceType.camera)) {
            await Permission.camera.request();
          }
          if (request.types.contains(WebViewPermissionResourceType.microphone)) {
            await Permission.microphone.request();
          }
          request.grant(); 
        },
      );

      androidController.setMediaPlaybackRequiresUserGesture(false);

      androidController.setOnShowFileSelector((params) async {
        try {
          await [Permission.photos, Permission.storage].request();

          final result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'tiff', 'pdf'],
          );
          if (result != null && result.files.single.path != null) {
            return [Uri.file(result.files.single.path!).toString()];
          }
        } catch (e) {
          debugPrint("Error picking file: $e");
        }
        return [];
      });
    }

    _controller.loadRequest(
      Uri.parse(widget.checkoutUrl),
      headers: const {
        'X-Requested-With': '',
      },
    );
    
    if (mounted) {
      setState(() {
        _isControllerInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("KYC Verification"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          if (_isControllerInitialized)
            WebViewWidget(controller: _controller)
          else
            const Center(child: CircularProgressIndicator()),
            
          if (_isLoading && _isControllerInitialized)
            const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ),
        ],
      ),
    );
  }
}
