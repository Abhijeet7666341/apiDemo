import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserDetail(),
    );
  }
}

class UserDetail extends StatefulWidget {
  UserDetail({Key key}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final String url =
      "https://www.ptrsclub.com.au/index.php/Api_user/index-post";
  List data;

  Future<String> getUser() async {
    var res = await http.get(Uri.parse(url));
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
    });

    return "Sucess!";
  }

  @override
  void initState() {
    super.initState();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(data[index]["id"].toString()),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    data[index]["first_name"] + " " + data[index]["last_name"]),
                Text(data[index]["address1"] +
                    data[index]["address2"] +
                    data[index]["address3"] +
                    data[index]["city"] +
                    data[index]["provice_region"] +
                    data[index]["postcode"]),
                Text(data[index]["email"]),
                Text(data[index]["licence"] + data[index]["licence_expiry"]),
                Text(data[index]["status"].toString()),
                Text(data[index]["created_by"] + data[index]["created_at"]),
                Text(data[index]["modified_by"] + data[index]["modified_at"]),
              ],
            ),
            subtitle: Text(data[index]["phone"].toString()),
          );
        },
      ),
    );
  }
}
