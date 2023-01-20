import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ReusableCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final Widget? errorWidget;
  final double? height;
  final double? width;
  final BorderRadius borderRadius;
  final BoxFit fit;

  const ReusableCachedNetworkImage(
      {Key? key,
        this.imageUrl,
        this.height,
        this.width,
        this.fit = BoxFit.contain,
        this.borderRadius = BorderRadius.zero,
        this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: imageUrl!,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[600]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Theme.of(context).focusColor,
            ),
          ),
        ),
        errorWidget: (context, url, error) =>
        errorWidget ??
            Icon(
              Icons.error,
              size:height!=null? height! * 0.5:25,
            ),
      ),
    );
  }
}