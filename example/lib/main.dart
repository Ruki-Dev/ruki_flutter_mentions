import 'dart:convert';
import 'dart:math';

import 'package:example/pub_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (_, child) => Portal(child: child!),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();

  Future<List<Map<String, dynamic>>> sampleRequest(query) async {
    var url = Uri.parse('https://api.publicapis.org/entries?title=$query');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> apis = [];
      for (int i = 0; i < min(data['entries']?.length??0, 10); i++) {
        apis.add(Map<String, dynamic>.from(data['entries'][i]));
      }
      print(apis);
      return apis;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ElevatedButton(
            child: Text('Get Text'),
            onPressed: () {
              print(key.currentState!.controller!.markupText);
            },
          ),
          Container(
            child: FlutterMentions(
              key: key,
              suggestionPosition: SuggestionPosition.Top,
              maxLines: 5,
              minLines: 1,
              forceListHeight: true,
              decoration: InputDecoration(hintText: 'hello'),
              onAsyncSearchChanged: (trigger, value) {
                if (trigger == '@' && value.length > 0) {
                  return sampleRequest(value);
                }
                return Future.value([]);
              },
              suggestionListHeight: MediaQuery.of(context).size.height,
              mentions: [
                Mention(
                    trigger: '@',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                   useAsync: true,
                   matchAll: false,
                   displayTarget: 'API',
                   displayId: "API",
                    suggestionBuilder: (data) {
                      return ListTile(
                        title: Text(data['API']),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['Description']),
                        ),
                      );
                    }),
                Mention(
                  trigger: '#',
                  disableMarkup: true,
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  data: [
                    {'id': 'reactjs', 'display': 'reactjs'},
                    {'id': 'javascript', 'display': 'javascript'},
                  ],
                  matchAll: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
