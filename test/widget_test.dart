import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_list/components/my_search_bar.dart';
import 'package:photo_list/components/photo_grid_view.dart';
import 'package:photo_list/components/photo_grid_view_cell.dart';
import 'package:photo_list/components/search_button.dart';
import 'package:photo_list/main.dart';
import 'package:http/http.dart' as http;
import 'package:photo_list/model/photo_payload.dart';
import 'package:photo_list/view/detail.dart';
import 'package:photo_list/view/home.dart';

void main() {
  testWidgets('Test Search Button', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child:
            SearchButton(key: Key("search_button"), onPressed: (icon) {}),
          ),
        ),
      ),
    ));

    expect(find.byIcon(Icons.search), findsOneWidget);
    await tester.tap(find.byType(SearchButton));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.cancel), findsOneWidget);
  });

  testWidgets('Test Search Bar', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: MySearchBar(
              controller: TextEditingController(),
              onChanged: (String) {},
            ),
          ),
        ),
      ),
    ));

    expect(find.byType(MySearchBar), findsOneWidget);
    await tester.enterText(find.byType(MySearchBar), "It is widget test!!!");
    await tester.pumpAndSettle();
    expect(find.text("It is widget test!!!"), findsOneWidget);
  });

  testWidgets('Test Photos Grid View', (tester) async {
    final photos = List<PhotoPayload>.generate(100, (i) =>
        PhotoPayload(
            createdAt: "2023-03-30T10:06:51.596Z",
            url:
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1026.jpg",
            description:
            "New ABC 13 9370, 13.3, 5th Gen CoreA5-8250U, 8GB RAM, 256GB SSD, power UHD Graphics, OS 10 Home, OS Office A & J 2016",
            location: "Ashaton",
            createdBy: "Marilyn Graham",
            takenAt: "2022-05-10T18:31:28.167Z",
            id: "$i"));
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
              child: CustomScrollView(
                slivers: [
                  PhotoGridView(
                    photos: photos,
                    onTapOne: (paylaod) {},
                  ),
                ],
              )),
        ),
      ),
    ));

    await tester.scrollUntilVisible(
      find.byKey(ValueKey("photo_12")),
      500.0,
      scrollable: find.byType(Scrollable),
    );

    expect(find.byKey(ValueKey("photo_12")), findsOneWidget);
  });

}
