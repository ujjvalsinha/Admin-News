import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:completenews/Nextpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_html/flutter_html.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    var url = "http://news.raushanjha.in/flutterapi/public/index.php/getnewsall";
  var data;
  var tittle = "All";

  spin() {
    // return SpinKitRotatingPlain(color: Colors.red);
    return SpinKitChasingDots(color: Colors.red);

  }

  notfound() {
    return Container(
        height: 200,
        width: double.infinity,
        child: Image.asset("images/notfound.png",fit: BoxFit.cover,));
  }
  notfoundletter() {
    return Container(
        height: 80,
        width: double.infinity,
        child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXDWbdfH5fil8b0nCVgejI4PIailBeEuXgbTyaYjqd8Swd8uT_&s"));
  }

  Future<String> getjsondata() async {
    var response = await http.get(Uri.encodeFull(url));
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
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
             
               
              ListTile(
                title: Text(
                  "Flutter",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward),
                // onTap: () {
                //   tittle = "Technolgy";
                //   url =
                //       "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=2d876e297540454b908c7258890cb059";
                //   getjsondata();
                //   Navigator.pop(context);
                // },
              ),
            ],
          ),
        ),
        body: data == null
            ? spin()
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    iconTheme: new IconThemeData(color: Colors.red[900]),
                    title: Row(
                      children: <Widget>[
                        Container(
                            height: 130,
                            width: 130,
                            child: Image.asset("images/LOGO.png")),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          // child: Text(tittle,style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    actions: <Widget>[],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Container(
                        height: 125,
                        width: 100,
                        child: data[index]["news_image"] != null
                            ? CachedNetworkImage(
                                          imageUrl: "http://news.raushanjha.in/upload/${data[index]["news_image"]}",fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              spin(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                            : notfound()),
                    title:
                         Container(
                            child: Html(data:
                              data[index]["news_title"],
                               
                            ),
                          )
                         ,
                    onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Nextpage(data, index)),
                              );
                            },
                  ),
                ),
              ),
                      childCount: data == null ? 0 : data.length,
                    ),
                  ),
                ],
              ));
  }
}
