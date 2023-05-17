import 'dart:io';
import 'package:flutter/material.dart';
import 'package:techeablemachine/pages/classifier.dart';
import 'package:image/image.dart' as img;
import 'package:techeablemachine/pages/classifier_quant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

void main() {
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
          title: 'Flutter Demo Home Page'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  late Classifier _classifier;
  var logger = Logger();
  File? _image;
  final picker = ImagePicker();
  Image? _imageWidget;
  img.Image? fox;
  Category? category;


  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
  }

  Future getImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickerFile!.path);
      _imageWidget = Image.file(_image!);
      _predict();
    });
  }

  void _predict() async {
    img.Image? imageInput = img.decodeImage(_image!.readAsBytesSync());
    var pred = _classifier.predict(imageInput!);

    setState(() {
      this.category = pred;
    });




}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TFlite de Perros y Gatos'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: _image == null ? Text('Ninguna imagen a sido seleccionada')
                : Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery
                      .of(context)
                      .size
                      .height / 2
              ),
              decoration: BoxDecoration(
                  border: Border.all()
              ),
              child: _imageWidget,
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Text(
              category != null ? category!.label:''
          ),
          SizedBox(
            height: 8,
          ),
          Text(
              category!=null
                  ?'Nivel de confianza:${(category!.score).toStringAsFixed(3)}':''
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Selecciona imagen',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
  }
