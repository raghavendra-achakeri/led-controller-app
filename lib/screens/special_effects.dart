import 'package:flutter/material.dart';

class SpecialEffects extends StatefulWidget {
  SpecialEffects({Key key, this.onEffectPress}) : super(key: key);
  final Function onEffectPress;

  @override
  _SpecialEffectsState createState() => _SpecialEffectsState();
}

class _SpecialEffectsState extends State<SpecialEffects> {
  List colorEffects = [
    {"label": "Static", "value": "0"},
    {"label": "Blink", "value": "1"},
    {"label": "Breath", "value": "2"},
    {"label": "Color Wipe", "value": "3"},
    {"label": "Color Wipe Inverse", "value": "4"},
    {"label": "Color Wipe Reverse", "value": "5"},
    {"label": "Color Wipe Reverse Inverse", "value": "6"},
    {"label": "Color Wipe Random ", "value": "7"},
    {"label": "Random Color ", "value": "8"},
    {"label": "Single Dynamic", "value": "9"},
    {"label": "Multi Dynamic", "value": "10"},
    {"label": "Rainbow", "value": "11"},
    {"label": "Rainbow Cycle", "value": "12"},
    {"label": "Scan", "value": "13"},
    {"label": "Dual Scan", "value": "14"},
    {"label": "Fade ", "value": "15"},
    {"label": "Theater Chase", "value": "16"},
    {"label": "Theater Chase Rainbow", "value": "17"},
    {"label": "Running Lights ", "value": "18"},
    {"label": "Twinkle", "value": "19"},
    {"label": "Twinkle Random", "value": "20"},
    {"label": "Twinkle Fade", "value": "21"},
    {"label": "Twinkle Fade Random", "value": "22"},
    {"label": "Flash Sparkle", "value": "23"},
    {"label": "Hyper Sparkle", "value": "24"},
    {"label": "Strobe Rainbow ", "value": "25"},
    {"label": "Multi Strobe", "value": "27"},
    {"label": "Blink Rainbow", "value": "28"},
    {"label": "Chase White ", "value": "29"},
    {"label": "Chase Color", "value": "30"},
    {"label": "Chase Random", "value": "31"},
    {"label": "Chase Rainbow ", "value": "32"},
    {"label": "Chase Flash", "value": "33"},
    {"label": "Chase Flash Random ", "value": "34"},
    {"label": "Chase Rainbow White", "value": "35"},
    {"label": "Chase Blackout", "value": "36"},
    {"label": "Chase Blackout Rainbow", "value": "37"},
    {"label": "Color Sweep Random", "value": "38"},
    {"label": "Running Color", "value": "39"},
    {"label": "Running Red Blue", "value": "40"},
    {"label": "Running Random", "value": "41"},
    {"label": "Larson Scanner", "value": "42"},
    {"label": "Comet", "value": "43"},
    {"label": "Fireworks", "value": "44"},
    {"label": "Fireworks Random", "value": "45"},
    {"label": "Merry Christmas ", "value": "46"},
    {"label": "Fire Flicker ", "value": "47"},
    {"label": "Fire Flicker (soft)", "value": "48"},
    {"label": "Fire Flicker (intense)", "value": "49"},
    {"label": "Circus Combustus", "value": "50"},
    {"label": "Halloween", "value": "51"},
    {"label": "Bicolor Chase", "value": "52"},
    {"label": "Tricolor Chase", "value": "54"},
  ];

  Widget loadEachEffect(index) {
    return InkWell(
      onTap: () {
        widget.onEffectPress(colorEffects[index]);
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              colorEffects[index]["label"],
              style: TextStyle(fontSize: 18),
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }

  Widget specialEffectList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: colorEffects.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return loadEachEffect(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Special Effects",
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black.withOpacity(0.05),
          child: specialEffectList(),
        ),
      ),
    );
  }
}
