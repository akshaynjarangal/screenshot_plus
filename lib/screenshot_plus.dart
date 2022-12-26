library screenshot_plus;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class ScreenshotPlus extends StatelessWidget {
  final Widget child;
  const ScreenshotPlus({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
// RepaintBoundary is a widget that creates a separate display list for its
// children. This can improve performance by allowing the children to be drawn
// to an offscreen buffer and then composited into the screen using a single
// draw call. This is especially useful for widgets with complex visual
// effects, such as those that involve animations or gestures.

    return RepaintBoundary(key: key, child: child);
  }

  static Future<Uint8List?> takeScreenshot(
      {required GlobalKey globalKey}) async {
    try {
      // Then, use the RenderRepaintBoundary object's toImage method to create a
// Future that will resolve to an Image object containing the screenshot.
      var findRenderObject = globalKey.currentContext?.findRenderObject();
      if (findRenderObject == null) {
        return null;
      }
      RenderRepaintBoundary boundary =
          findRenderObject as RenderRepaintBoundary;
      BuildContext? context = globalKey.currentContext;
      //image object to create a File or do whatever you want with the screenshot.
      ui.Image image = await boundary.toImage(
          pixelRatio: MediaQuery.of(context!).devicePixelRatio);
      // Convert the Image object to a Flutter ImageByteFormat.png byte data.
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      //pngBytes returns image bytes
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } on Exception {
      throw Exception;
    }
  }
}
