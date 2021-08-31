import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pagination/model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  int pageNumber = 0;
  int totalPage = 1;
  List<Datum> list = [];
  var refreshController = RefreshController();
  Future<bool> getData() async {
    if (pageNumber >= totalPage) {
      refreshController.loadComplete();
      return true;
    }

    String url =
        'https://api.instantwebtools.net/v1/passenger?page=$pageNumber&size=10#';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        final jsondata = welcomeFromJson(response.body);
        list = jsondata.data;
        totalPage = jsondata.totalPages;
        pageNumber++;
        print(pageNumber);
        print(totalPage);
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
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
          : SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              onLoading: () async {
                final result = await getData();
                if (result) {
                  refreshController.loadComplete();
                } else {
                  refreshController.loadFailed();
                }
              },
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final _list = list[index];
                    return ListTile(
                      title: Text(_list.name),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: list.length),
            ),
    );
  }
}
