import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const MyCachedNetworkImage({Key? key,
    required this.imageUrl,
    this.height, this.width,
    this.fit
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      placeholder: (_, __) => Container(
        alignment: Alignment.center,
        width: 44.3,
        height: 44,
        child: const Icon(
          Iconsax.image,
          size: 44,
        ),
      ),
      fit: fit ?? BoxFit.cover,
      alignment: Alignment.center,
      fadeInDuration: const Duration(milliseconds: 100),
      fadeOutDuration: const Duration(milliseconds: 10),
      errorWidget: (context, url, error) {
        return  const Center(
          child:  Icon(
          Iconsax.image,
          size: 44,
          color: Colors.grey,
        ),
        );
      },
    );
  }
}
