import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:connectivity/connectivity.dart';
import '../screens/special_effects.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int redColor;
  int blueColor;
  int greenColor;
  double doubleOpacity;
  int opacity;
  double _value = 10;
  String rgbDeviceURL;

  //connectify varible
  String wifiStatus;
  String gateWay;
  var wifiIP;

  //websocket
  String url;
  WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    getIp();
    getGatewayIP();
  }

  getIp() async {
    wifiIP = await (Connectivity().getWifiIP());
    wifiStatus = wifiIP == null ? "Connect Wifi" : "Connected";
    setState(() {
      wifiStatus = wifiStatus;
      wifiIP = wifiIP;
    });
    gateWay = wifiIP.toString().substring(0, 10) + "10:81";
    rgbDeviceURL = "ws://$gateWay";
  }

  getGatewayIP() async {}

  sendRequest(payload) {
    try {
      channel = WebSocketChannel.connect(Uri.parse(url));
      print(payload);
      channel.sink.add(payload);
      channel.sink.close();
    } catch (err) {
      print(err);
    }
  }

  Widget heading() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          "LED Control",
          style: TextStyle(fontSize: 28, color: Colors.black54),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    setState(
      () => pickerColor = color,
    );
    redColor = pickerColor.red;
    blueColor = pickerColor.blue;
    greenColor = pickerColor.green;
    doubleOpacity = pickerColor.opacity;
    opacity = Color.getAlphaFromOpacity(doubleOpacity);
  }

  onEffectPress(effectObj) {
    final jsonEncoder = JsonEncoder();
    Map effectPayload = {};
    effectPayload['type'] = "BUILT_IN";
    effectPayload['mode_no'] = effectObj['value'];
    sendRequest(jsonEncoder.convert(effectPayload));
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
      ),
    );
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

  Widget checkWifiConnectivity() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.0),
          //       color: wifiStatus == "Connected" ? Colors.green : Colors.grey,
          //     ),
          //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          //     child: GestureDetector(
          //       onTap: () {
          //         getIp();
          //       },
          //       child: Text(
          //         wifiStatus ?? "",
          //         style: TextStyle(color: Colors.white, fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),
          // Container(width: 20),
          Container(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blueAccent,
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  sendRequest('{"type": "STATIC", "r": $redColor,"g":$greenColor,"b":$blueColor}');
                },
                child: Text(
                  "Apply Color",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget specialColorsEffect() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SpecialEffects(onEffectPress: onEffectPress)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "Special Color Effects",
                style: TextStyle(color: Colors.grey, fontSize: 22),
              ),
            ),
            Container(
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LED Control",
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              // heading(),
              Divider(
                color: Colors.transparent,
                height: 20,
              ),
              Divider(
                color: Colors.black38,
                height: 5,
              ),

              specialColorsEffect(),
              Divider(
                color: Colors.black38,
                height: 5,
              ),

              brightnessController(),
              staticColors(),
              // wifistatusBar(),
              checkWifiConnectivity(),
            ],
          ),
        ),
      ),
    );
  }
}
