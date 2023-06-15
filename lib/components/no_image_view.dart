import 'package:flutter/material.dart';

class NoImageView extends StatelessWidget {

  const NoImageView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            size: 90,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "No Any Photos =[",
              style: TextStyle(fontSize: 24, color: Colors.black38),
            ),
          ),
          SizedBox(
            height: 180,
          ),
        ],
      ),
    );
  }
}
