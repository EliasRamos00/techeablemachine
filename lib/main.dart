



import 'package:flutter/material.dart';
import 'package:techeablemachine/pages/classifier.dart';

void main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: "Image Classification",
        theme: ThemeData(
          primaryColor: Colors.amber
        ),
        home: MyHomePage(
          title:'Flutter Demo Home Page'
        ),
      );
  }
}
class MyHomePage extends StatefulWidget{

  MyHomePage({Key? key, this.title}): super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{
  late Classifier _classifier;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}