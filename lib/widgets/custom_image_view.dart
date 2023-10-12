import 'package:cached_network_image/cached_network_image.dart';
import 'package:gossip_grove/core/app_export.dart';

Widget customImageView({
  required String url,
  required double imgHeight,
  required double imgWidth,
  BoxFit fit = BoxFit.cover,
  double borderRadius = 12,
  double radiusTopLeft = 0,
  double radiusTopRight = 0,
  double radiusBottomLeft = 0,
  double radiusBottomRight = 0,
  bool isAssetImage = false,
}) {
  return ClipRRect(
    borderRadius: borderRadius > 0
        ? BorderRadius.circular(borderRadius)
        : BorderRadius.only(
            bottomLeft: Radius.circular(radiusBottomLeft),
            topLeft: Radius.circular(radiusTopLeft),
            topRight: Radius.circular(radiusTopRight),
            bottomRight: Radius.circular(radiusBottomRight),
          ),
    child: isAssetImage
        ? Image(
            image: AssetImage(url),
            height: imgHeight,
            width: imgWidth,
            fit: fit,
          )
        : CachedNetworkImage(
            imageUrl: url,
            fit: fit,
            height: imgHeight,
            width: imgWidth,
            placeholder: (context, url) => SizedBox(
              height: imgHeight,
              width: imgWidth,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              ChatImages.individualChatImage,
              height: imgHeight,
              width: imgWidth,
              fit: fit,
            ),
          ),
  );
}
