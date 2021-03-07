import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class RestaurantNetworkImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget placeholder;
  final Widget errorWidget;
  final double height;
  final double width;
  final String restaurantId;
  final bool useCachedNetworkImage = true;
  final bool useWrapperUrl = true;
  final int memCacheWidth;
  final int memCacheHeight;
  final int imageResizeHeight;
  final int imageResizeWidth;
  int imageUrlHeight;
  int imageUrlWidth;

  RestaurantNetworkImage({
    Key key,
    this.imageUrl,
    this.fit,
    this.errorWidget,
    this.placeholder,
    this.height,
    this.width,
    this.restaurantId,
    this.memCacheWidth,
    this.memCacheHeight,
    this.imageResizeHeight,
    this.imageResizeWidth,
  }) : super(key: key){
    if(imageResizeHeight == null || imageResizeWidth == null){
      if(height == null || width == null){
        imageUrlHeight = 500;
        imageUrlWidth = 500;
      }
      else{
        imageUrlHeight = height.toInt();
        imageUrlWidth = width.toInt();
      }
    } else {
      imageUrlHeight = imageResizeHeight;
      imageUrlWidth = imageResizeWidth;
    }
  }

  @override
  _RestaurantNetworkImageState createState() => _RestaurantNetworkImageState();
}

class _RestaurantNetworkImageState extends State<RestaurantNetworkImage> {
  @override
  Widget build(BuildContext context) {
    var extendedUrl = 'https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=${widget.imageUrlWidth.toString()},height=${widget.imageUrlHeight.toString()},format=auto/';
    if (widget.useCachedNetworkImage) {
      return CachedNetworkImage(
        imageUrl: widget.useWrapperUrl ? extendedUrl + widget.imageUrl : widget.imageUrl,
        fit: widget.fit,
        placeholder: (context, value) {
          return widget.placeholder;
        },
        errorWidget: (context, value, i) {
          return widget.errorWidget;
        },
        height: widget.height,
        width: widget.width,
        memCacheWidth: widget.memCacheWidth,
        memCacheHeight: widget.memCacheHeight,
      );
    } else {
      return Image.network(
        widget.useWrapperUrl ? extendedUrl + widget.imageUrl : widget.imageUrl,
        fit: widget.fit,
        errorBuilder: (context, value, i) {
          return widget.errorWidget;
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) {
            return child;
          }
          return widget.placeholder;
        },
        cacheHeight: widget.memCacheWidth,
        cacheWidth: widget.memCacheHeight,
      );
    }
  }
}
