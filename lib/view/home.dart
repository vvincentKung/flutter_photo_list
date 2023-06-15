import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_list/components/no_image_view.dart';
import 'package:photo_list/components/photo_grid_view.dart';
import 'package:photo_list/controller/main_controller.dart';
import 'package:photo_list/model/photo_payload.dart';
import 'dart:async';

import '../components/photo_grid_view_cell.dart';
import '../components/my_search_bar.dart';
import '../components/search_button.dart';
import '../util/global_key.dart';
import './detail.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget customSearchBar = const Text('Photo List');
  Timer? _debounce;

  List<PhotoPayload> photos = [];
  late TextEditingController _textEditingController;
  late Controller _controller;
  late ScrollController _scrollController;
  var isAll = false;
  var page = 1;
  var searchKey = '';

  Future<void> _refresh() async {
    this.page = 1;
    var result = await _controller.refreshData(searchKey: this.searchKey);
    result.when(
      (success) {
        setState(() {
          photos = success;
          isAll = success.length == 0;
        });
      },
      (error) {
        print("refresh,error=>$error");
        showDialog(
            barrierDismissible: false,
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Cannot load photos, please try again!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      },
    );
  }

  Future<bool> _loadMore() async {
    this.page += 1;
    var result = await _controller.loadMoreData(
        page: this.page, searchKey: this.searchKey);
    result.when(
      (success) {
        setState(() {
          photos += success;
          isAll = success.length == 0;
        });
      },
      (error) {
        print("loadMore,error=>$error");
        showDialog(
            barrierDismissible: false,
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Cannot load photos, please try again!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      },
    );
    return true;
  }

  void _scrollListener() {
    print('Scroll Listener Called!!');
    if (_scrollController.hasClients) {
      if ((_scrollController.position.maxScrollExtent) ==
          _scrollController.offset) {
        _loadMore();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = Controller();
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    _scrollController.addListener(_scrollListener);
    _refresh();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    AppBar _appBar = AppBar(
      title: customSearchBar,
      automaticallyImplyLeading: false,
      actions: [
        SearchButton(
            key: Key("search_button"),
            onPressed: (icon) {
              setState(() {
                if (icon == Icons.cancel) {
                  customSearchBar = MySearchBar(
                    controller: _textEditingController,
                    onChanged: (String value) {
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 200), () {
                        this.searchKey = value;
                        this._refresh();
                      });
                    },
                  );
                } else {
                  this.searchKey = '';
                  _textEditingController.clear();
                  customSearchBar = const Text('Photo List');
                  this._refresh();
                }
              });
            }),
      ],
      centerTitle: true,
    );

    return Scaffold(
        appBar: _appBar,
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return _refresh();
                    },
                    child: photos.length == 0
                        ? SingleChildScrollView(
                            child: const NoImageView(),
                          )
                        : CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              PhotoGridView(
                                  photos: this.photos,
                                  onTapOne: (payload) {
                                    Navigator.pushNamed(
                                      context,
                                      DetailPage.routeName,
                                      arguments: DetailPageArguments(payload),
                                    );
                                  }),
                              SliverToBoxAdapter(
                                child: isAll || photos.length < 10
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          "Now loading",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            )));
  }
}
