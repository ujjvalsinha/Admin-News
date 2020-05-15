import 'package:completenews/Managecategory.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Cateogory extends StatefulWidget {
  @override
  _CateogoryState createState() => _CateogoryState();
}

class _CateogoryState extends State<Cateogory> {
  spin() {
    return SpinKitRotatingPlain(color: Colors.red);
  }

  var data;
  var url = "http://news.raushanjha.in/flutterapi/category";
  Future<String> getjsondata() async {
    var response = await http.get(url);
    if (mounted) {
      setState(() {
        var convertdata = json.decode(response.body);
        data = convertdata;
        print(data);
      });
    }
  }

  @override
  void initState() {
    getjsondata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),

        // visible: _dialVisible,

        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.settings),
              backgroundColor: Colors.red,
              label: 'Manage Category',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ManageCategory()))),
          SpeedDialChild(
            child: Icon(Icons.book),
            backgroundColor: Colors.blue,
            label: 'Terms & Condition',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
        ],
      ),
      body: data != null
          ? Card(elevation: 2,
                      child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 60, top: 20),
                          height: 140,
                          width: 200,
                          child: CachedNetworkImage(
                            imageUrl: data[index]["category_image"],
                            placeholder: (context, url) =>
                                spin(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 170, left: 14),
                          height: 70,
                          width: MediaQuery.of(context).size.width * 0.99,
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            data[index]["category_name"],
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height:4,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          : spin(),
    );
  }
}
