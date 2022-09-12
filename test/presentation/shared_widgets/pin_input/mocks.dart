import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MockClipboard {
  dynamic _clipboardData = <String, dynamic>{
    'text': null,
  };

  MockClipboard() {
    SystemChannels.platform.setMockMethodCallHandler(handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'Clipboard.getData':
        return _clipboardData;
      case 'Clipboard.setData':
        _clipboardData = methodCall.arguments;
        break;
    }
  }

  /// Invoke the clipboard setData method
  void setClipboardData(String? text) {
    SystemChannels.platform.invokeMethod('Clipboard.setData', {'text': text});
  }
}
