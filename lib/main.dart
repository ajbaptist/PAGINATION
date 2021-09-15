import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pagination/model.dart';

List<Temperatures> list = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getData();

    super.initState();
  }

  Future getData() async {
    String url = 'https://jsonplaceholder.typicode.com/todos';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsondata = temperaturesFromJson(response.body);

      list = jsondata;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('PAGINATION'),
        ),
        body: list.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) {
                  final _list = list[index];
                  return ListTile(
                    title: Text(_list.title),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: list.length));
  }
}
