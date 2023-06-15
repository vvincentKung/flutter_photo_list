import 'package:flutter/material.dart';


class SearchButton extends StatefulWidget {
  const SearchButton({Key? key, required this.onPressed}): super(key: key);

  final void Function(IconData icon) onPressed;
  @override
  _SearchButtonState createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {

  Icon customIcon = const Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key("search_bar_icon_button"),
      onPressed: () {
        setState(() {
          if (customIcon.icon == Icons.search) {
            customIcon = const Icon(Icons.cancel);
          } else {
            customIcon = const Icon(Icons.search);
          }
        });
        widget.onPressed(this.customIcon.icon!);
      },
      icon: this.customIcon,
    );
  }
}
