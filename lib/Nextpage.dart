//import 'dart:html';

import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

class Nextpage extends StatefulWidget {
  var data1, index;
  Nextpage(this.data1, this.index);
  @override
  _NextpageState createState() => _NextpageState(data1, index);
}

class _NextpageState extends State<Nextpage> {
  notfound() {
    return Container(
        height: 200,
        width: double.infinity,
        child: Image.asset("images/notfound.png",fit: BoxFit.cover,));
  }
  String title;

  var data2, index1;
  var text;
  _NextpageState(this.data2, this.index1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" "),
          
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Card(
                      elevation: 1,
                      child:data2[index1]["news_image"]!=null? Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            "http://news.raushanjha.in/upload/${data2[index1]["news_image"]}",fit: BoxFit.cover,
                          )):notfound()
                    ),
                    Container(
                        height: 230,
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.bookmark,
                            size: 30,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Card(
                  elevation: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        height: 55,
                        width: double.infinity,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              data2[index1]["news_title"],
                              style: TextStyle(
                                  fontSize: 24, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 10),
                              child: Icon(Icons.calendar_today)),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(data2[index1]["news_date"]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 1,
                  child: Container(
                      margin: EdgeInsets.all(15),
                      child: Html(data: data2[index1]["news_description"])),
                ),
                Card(
                  elevation: 1,
                  child: Container(
                      height: 50,
                      width: 400,
                      child: Image.network(
                        data2[index1]["news_date"],
                      )),
                ),
              ],
            )
          ],
        ));
  }
}
