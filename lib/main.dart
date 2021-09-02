import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xffFFA000)),
      title: 'Caculadora de Área',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Caculadora de Área'),
        ),
        body: AreaCalculator(),
      ),
    );
  }
}

class AreaCalculator extends StatefulWidget {
  @override
  _AreaCalculatorState createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  List<String> shapes = ['Retangulo', 'Triangulo'];
  late String currentShape;
  String result = '0';
  double width = 0;
  double height = 0;

  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    result = '0';
    currentShape = 'Retangulo';
    widthController.addListener(updateWidth);
    heightController.addListener(updateHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            //dropdown
            DropdownButton<String>(
                value: currentShape,
                items: shapes.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  );
                }).toList(),
                onChanged: (shape) {
                  setState(() {
                    currentShape = shape!;
                  });
                }),
            //shape
            // ShapeContainer(
            //   shape: currentShape,
            // ),
            //width
            AreaTextField(controller: widthController, hint: 'Largura'),
            //height
            AreaTextField(controller: heightController, hint: 'Altura'),
            Container(
              margin: EdgeInsets.all(15.0),
              child: RaisedButton(
                child: Text(
                  'Calcular',
                  style: TextStyle(fontSize: 18.0),
                ),
                //color: Colors.lightBlue,
                onPressed: calculateArea,
              ),
            ),
            Text(
              result,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.green[700],
              ),
            ),
          ],
        )));
  }

  void calculateArea() {
    double area;

    if (currentShape == 'Retangulo') {
      area = width * height;
    } else if (currentShape == 'Triangulo') {
      area = width * height / 2;
    } else {
      area = 0;
    }
    setState(() {
      result = 'Sua area é ' + area.toString();
    });
  }

  void updateWidth() {
    setState(() {
      if (widthController.text != '') {
        width = double.parse(widthController.text);
      } else {
        width = 0;
      }
    });
  }

  void updateHeight() {
    setState(() {
      if (heightController.text != '') {
        height = double.parse(heightController.text);
      } else {
        height = 0;
      }
    });
  }
}

class AreaTextField extends StatelessWidget {
  AreaTextField({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15.0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.w300,
              fontSize: 24.0),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.border_all),
            filled: true,
            fillColor: Colors.grey[300],
            hintText: hint,
          ),
        ));
  }
}
