import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  double _value = 10;
  Widget heading() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            "LED Control",
            style: TextStyle(fontSize: 28, color: Colors.black54),
          )),
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Widget brightnessController() {
    return Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              child: Text(
                "Brightness",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.brightness_5_outlined,
                      color: Colors.black38,
                      size: 30.0,
                    ),
                  ),
                  Expanded(
                    child: SfSlider(
                      min: 0.0,
                      max: 100.0,
                      activeColor: Colors.blue,
                      value: _value,
                      interval: 25,
                      showTicks: true,
                      showLabels: true,
                      showTooltip: true,
                      tooltipShape: SfPaddleTooltipShape(),
                      inactiveColor: Colors.black38,
                      tooltipTextFormatterCallback: (dynamic actualValue, String formattedText) {
                        return actualValue.floor().toString();
                      },
                      minorTicksPerInterval: 0,
                      onChanged: (dynamic value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(
                      Icons.brightness_7_outlined,
                      color: Colors.black45,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget staticColors() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            child: Text(
              "Static Color",
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Center(
              child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
                showLabel: false,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              heading(),
              brightnessController(),
              staticColors(),
            ],
          ),
        ),
      ),
    );
  }
}
