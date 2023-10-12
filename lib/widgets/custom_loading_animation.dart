import 'package:gossip_grove/core/app_export.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget customButtonLoadingAnimation({
  required double size,
  Color color = WhiteColor.white,
}) {
  return LoadingAnimationWidget.prograssiveDots(
    color: color,
    size: getSize(size),
  );
}

Widget customPageLoadingAnimation({
  required double size,
  Color color = AppColor.primaryColor,
}) {
  return LoadingAnimationWidget.staggeredDotsWave(
    color: color,
    size: getSize(size),
  );
}