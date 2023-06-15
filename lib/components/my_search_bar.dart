import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key, required this.controller, required this.onChanged})
      : super(key: key);

  final void Function(String) onChanged;
  final TextEditingController controller;

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  Icon customIcon = const Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.search,
        color: Colors.black,
        size: 28,
      ),
      title: TextField(
        key: Key("search_bar_text_field"),
        controller: widget.controller,
        // onSubmitted: (String value) {
        //   this.searchKey = value;
        //   this._refresh();
        // },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.black26,
            fontSize: 17,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
