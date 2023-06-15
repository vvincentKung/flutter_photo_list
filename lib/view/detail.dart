import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_list/model/photo_payload.dart';

class DetailPageArguments {
  final PhotoPayload payload;

  DetailPageArguments(this.payload);
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailPageArguments;
    print("Photo Detail,Args=> $args");

    return Scaffold(
        appBar: AppBar(
          title: const Text("Photo Detail"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: args.payload.url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fitWidth),
                    ),
                  ),
                  placeholder: (context, url) => const SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                    height: 15.0,
                    width: 15.0,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name of Creator",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      key: Key("creator_name_text"),
                      "${args.payload.createdBy}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        key: Key("location_text"),
                        "${args.payload.location}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45),
                      )
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        key: Key("description_text"),
                        "${args.payload.description}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45),
                      )
                    ]),
              ),
            ],
          ),
        ));
  }
}
