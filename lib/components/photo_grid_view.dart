import 'package:flutter/material.dart';
import 'package:photo_list/components/photo_grid_view_cell.dart';

import '../model/photo_payload.dart';

class PhotoGridView extends StatelessWidget {

  const PhotoGridView({Key? key, required this.photos, required this.onTapOne}) : super(key: key);

  final List<PhotoPayload> photos;
  final void Function(PhotoPayload payload) onTapOne;

  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate:
      SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return PhotoGridViewCell(payload: photos[index], onTap: onTapOne);
        },
        childCount: photos.length,
      ),
    );
  }
}
