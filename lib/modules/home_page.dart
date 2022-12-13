// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/news_api_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<NewsResModel>(
        future: getNewsData(),
        builder: (context, AsyncSnapshot<NewsResModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.articles!.length,
              itemBuilder: (context, index) {
                var res = snapshot.data!.articles![index];
                return ListTile(
                  title: Text('${res.author}') ?? const Text('123'),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<NewsResModel> getNewsData() async {
  http.Response response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=tesla&from=2022-09-15&sortBy=publishedAt&apiKey=6c5a2cd029a44eb186c8640325bd2901'));
  log('response ====>${response.body}');

  var result = jsonDecode(response.body);

  NewsResModel data = NewsResModel.fromJson(result);
  return data;
}
