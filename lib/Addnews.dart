import 'dart:convert';
import 'dart:io';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddNews extends StatefulWidget {
  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  String _mySelection;
  File _image;
  Future getimage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  final titleobj = TextEditingController();
  final datelobj = TextEditingController();
  final catobj = TextEditingController();
  final desobj = TextEditingController();
  String newdate = DateTime.now().toString();

  String txt = "";
  int count = 0;
  Color col;

  Future<List> send() async {
    print("fdghgs");
    final response = await http
        .post("http://news.raushanjha.in/flutterapi/insertnews.php", body: {
      "news_title": titleobj.text,
      "news_description": desobj.text,
      "news_date": newdate,
      "cat_id": _mySelection
    });
  }

  List data = List();
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
     // backgroundColor:  //Color(0xFF99FFCC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          // Container(
          //         child: Image.asset("images/LOGO.png"),

          //       ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 7),
            child: TextField(
              controller: titleobj,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Tittle",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 7, 25, 7),
            child: DatePickerTimeline(
              DateTime.now(),
              onDateChange: (date) {
                // New date selected

                print(newdate);
                print(date.day.toString());
              },
            ),
          ),
          Container(
            width: 300,
            margin: EdgeInsets.fromLTRB(25, 7, 25, 15),
            child: MaterialButton(
                color: Colors.white,
                height: 50,
                minWidth: 200,
                splashColor: Colors.green,
                child: Text(
                  "Choose Image",
                  style: TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  getimage();
                }),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25, 2, 25, 0),
              child: Text(
                "Select Category",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
            child: DropdownButton(
              items: data.map((item) {
                return DropdownMenuItem(
                  child: new Text(item['category_name']),
                  value: item['cid'].toString(),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _mySelection = newVal;
                  print(_mySelection);
                });
              },
              value: _mySelection,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 7, 25, 15),
            child: TextField(
              controller: desobj,
              maxLines: 4,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 20, 25, 15),
            child: MaterialButton(
                color: Colors.red[900],
                height: 50,
                minWidth: 200,
                splashColor: Colors.green,
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20.0),
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  send();
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
}
