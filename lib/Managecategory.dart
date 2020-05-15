import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ManageCategory extends StatefulWidget {
  @override
  _ManageCategoryState createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
final nameobj = TextEditingController();
String txt = "";
Color col;
  

  Future<List> send() async{
    print("fdghgs");
    final response = await http.post("http://news.raushanjha.in/flutterapi/news1",body: {
    "name": nameobj.text,
});

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xFF99FFCC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
                child: Image.asset("images/LOGO.png"),
              ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 7),
            child: TextFormField(
              controller: nameobj,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Category",
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
                  "SEND",
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
          Container(
            child: Text(
              txt,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
