// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_list/model/photo_payload.dart';
import 'package:photo_list/remote/api_manager.dart';
import 'package:http/http.dart' as http;
import 'fetch_photos_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchPhotos', () {
    test('return photo list with first 10 photos', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              'https://64266c9f556bad2a5b4f7749.mockapi.io/photos?page=1&limit=10&sortBy=takeAt')))
          .thenAnswer((_) async => http.Response("""
          [{"createdAt":"2023-03-31T02:04:59.404Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/858.jpg","description":"Andy shoes are designed to keeping in mind durability as well as trends, the most stylish range of shoes & sandals","location":"Hayleeboro","createdBy":"Blake Lynch","takenAt":"2022-07-09T03:43:45.480Z","id":"1"},
          {"createdAt":"2023-03-30T06:31:29.592Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/876.jpg","description":"Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles","location":"East Orville","createdBy":"Emmett O'Conner","takenAt":"2023-01-18T02:29:44.718Z","id":"2"},
          {"createdAt":"2023-03-30T12:32:26.431Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/769.jpg","description":"The automobile layout consists of a front-engine design, with transaxle-type transmissions mounted at the rear of the engine and four wheel drive","location":"South Amani","createdBy":"Ernestine Rogahn","takenAt":"2023-03-22T13:16:16.196Z","id":"3"},
          {"createdAt":"2023-03-31T02:41:17.713Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/448.jpg","description":"New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart","location":"Catalina Foothills","createdBy":"Mrs. Kyle Jenkins","takenAt":"2022-05-01T12:00:35.188Z","id":"4"},
          {"createdAt":"2023-03-30T09:39:51.331Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/55.jpg","description":"The beautiful range of Apple Naturalé that has an exciting mix of natural ingredients. With the Goodness of 100% Natural Ingredients","location":"East Oleta","createdBy":"Emma Stoltenberg","takenAt":"2023-02-21T17:19:38.773Z","id":"5"},
          {"createdAt":"2023-03-30T21:16:26.542Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1212.jpg","description":"The slim & simple Maple Gaming Keyboard from Dev Byte comes with a sleek body and 7- Color RGB LED Back-lighting for smart functionality","location":"Hartford","createdBy":"Rachael Beer","takenAt":"2022-11-16T17:05:42.015Z","id":"6"},
          {"createdAt":"2023-03-30T21:55:14.461Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/26.jpg","description":"New ABC 13 9370, 13.3, 5th Gen CoreA5-8250U, 8GB RAM, 256GB SSD, power UHD Graphics, OS 10 Home, OS Office A & J 2016","location":"Bowling Green","createdBy":"Mrs. Luther Trantow","takenAt":"2023-03-31T05:25:10.507Z","id":"7"},
          {"createdAt":"2023-03-30T15:56:41.595Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/542.jpg","description":"Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles","location":"East Lorenz","createdBy":"Mr. Rachael Trantow","takenAt":"2022-05-07T13:35:56.924Z","id":"8"},
          {"createdAt":"2023-03-31T03:58:35.886Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/890.jpg","description":"Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles","location":"Modestacester","createdBy":"Leah Effertz","takenAt":"2023-01-27T01:25:29.510Z","id":"9"},
          {"createdAt":"2023-03-30T21:37:05.926Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/309.jpg","description":"The Apollotech B340 is an affordable wireless mouse with reliable connectivity, 12 months battery life and modern design","location":"Schowalterville","createdBy":"Heidi Hegmann","takenAt":"2022-10-12T08:30:42.691Z","id":"10"}]
          """, 200));

      expect(
          await ApiManager()
              .fetchPhotos(client, page: 1, limit: 10, sort: 'takeAt'),
          isA<List<PhotoPayload>>());
    });

    test('return empty photo list', () async {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
          'https://64266c9f556bad2a5b4f7749.mockapi.io/photos?page=11&limit=10&sortBy=takeAt')))
          .thenAnswer((_) async => http.Response('[]', 200));

      expect(
          await ApiManager()
              .fetchPhotos(client, page: 11, limit: 10, sort: 'takeAt'),
          isA<List<PhotoPayload>>());
    });

    test('return photos with search key', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              'https://64266c9f556bad2a5b4f7749.mockapi.io/photos?page=1&limit=10&sortBy=takeAt&search=Ashaton')))
          .thenAnswer((_) async => http.Response("""
          [{"createdAt":"2023-03-30T10:06:51.596Z","url":"https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1026.jpg","description":"New ABC 13 9370, 13.3, 5th Gen CoreA5-8250U, 8GB RAM, 256GB SSD, power UHD Graphics, OS 10 Home, OS Office A & J 2016","location":"Ashaton","createdBy":"Marilyn Graham","takenAt":"2022-05-10T18:31:28.167Z","id":"45"}]
          """, 200));

      expect(
          await ApiManager()
              .fetchPhotos(client, page: 1, limit: 10, sort: 'takeAt', searchKey: 'Ashaton'),
          isA<List<PhotoPayload>>());
    });

  });
}
