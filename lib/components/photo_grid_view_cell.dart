import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/photo_payload.dart';

class PhotoGridViewCell extends StatelessWidget {
  const PhotoGridViewCell({Key? key, required this.payload, required this.onTap})
      : super(key: key);

  final PhotoPayload payload;
  final void Function(PhotoPayload payload) onTap;

  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key("photo_${payload.id}"),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: payload.url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Center(
                child: SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(),
            )),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withAlpha(0),
                      Colors.black.withAlpha(150)
                    ])),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                payload.location,
                maxLines: 2,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        this.onTap(this.payload);
      },
    );
  }
}
