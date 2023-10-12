import 'package:flutter/material.dart';

final MediaQueryData data = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single);

get width {
  return data.size.width;
}

const num designWidth = 411;
const num designHeight = 826;
const num designStatusBar = 41;

///This method is used to get device viewport height.
get height {
  num statusBar = MediaQueryData.fromView(
          WidgetsBinding.instance.platformDispatcher.views.single)
      .viewPadding
      .top;
  num screenHeight = data.size.height - statusBar;
  return screenHeight;
}

double getHorizontalSize(double px) {
  return (px * width) / designWidth;
}

///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
double getVerticalSize(double px) {
  return (px * height) / (designHeight - designStatusBar);
}

///This method is used to set smallest px in image height and width
double getSize(double px) {
  var height = getVerticalSize(px);

  var width = getHorizontalSize(px);
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}

///This method is used to set text font size according to Viewport
double getFontSize(double px) {
  return getSize(px);
}
