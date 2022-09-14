import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SlutOpgaveHentnavnOgFarve',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => LandingPageState();
}

typedef void StringCallback(String val);
typedef void ColorCallback(Color val);

class LandingPageState extends State<LandingPage> {
  String _name = '';
  String _category = '';
  Color? _color = null;

  @override
  Widget build(BuildContext context) {
    String display_text = _name == '' && _category == ''
        ? 'Here comes the name'
        : '$_category: $_name';
    return Scaffold(
      appBar: AppBar(title: Text('SlutOpgaveHentnavnOgFarve')),
      body: Center(
          child: Column(children: <Widget>[
        const Text('Get Ones Name and Color'),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectNamePage(
                          name_cb: (value) => setState(() => _name = value),
                          category_cb: (value) =>
                              setState(() => _category = value),
                        )));
          },
          child: Text('GET ONES NAME'),
        ),
        Text(display_text,
            style: TextStyle(
                backgroundColor: _color == null ? Colors.white : _color)),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectColorPage(
                          category: _category,
                          color_cb: (value) => setState(() => _color = value),
                        )));
          },
          child: Text('GET ONES COLOR'),
        ),
      ])),
    );
  }
}

class SelectColorPage extends StatefulWidget {
  final ColorCallback color_cb;
  final String category;
  SelectColorPage({required this.color_cb, required this.category});

  @override
  State<SelectColorPage> createState() =>
      SelectColorPageState(color_cb: this.color_cb, category: this.category);
}

class HexColor extends Color {
  static int from_str(String hex_color) {
    hex_color = hex_color.toUpperCase().replaceFirst("#", "");
    if (hex_color.length == 6) {
      hex_color = "FF" + hex_color;
    }
    return int.parse(hex_color, radix: 16);
  }

  HexColor(final String hex_color) : super(from_str(hex_color));
}

class SelectColorPageState extends State<SelectColorPage> {
  final ColorCallback color_cb;
  final String category;
  String color_r = '00';
  String color_g = '00';
  String color_b = '00';

  SelectColorPageState({required this.color_cb, required this.category});

  @override
  Widget build(BuildContext context) {
    List<String> rgb_values = [];
    int current_color = 0;
    while (current_color <= 256) {
      rgb_values.add(min(current_color, 255).toRadixString(16).padLeft(2, '0'));
      current_color += 16;
    }
    return Scaffold(
      appBar: AppBar(title: Text('SlutOpgaveHentnavnOgFarve')),
      body: Center(
          child: Column(
        children: <Widget>[
          Text('$category Color'),
          SizedBox(
            width: 420.0,
            height: 42.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: HexColor('#$color_r$color_g$color_b'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Red'),
              DropdownButton(
                value: color_r,
                items: rgb_values.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      color_r = value;
                    });
                  }
                },
              ),
              Text('Green'),
              DropdownButton(
                value: color_g,
                items: rgb_values.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      color_g = value;
                    });
                  }
                },
              ),
              Text('Blue'),
              DropdownButton(
                value: color_b,
                items: rgb_values.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      color_b = value;
                    });
                  }
                },
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              color_cb(HexColor('#$color_r$color_g$color_b'));
              Navigator.pop(context);
            },
            child: Text('SEND COLOR'),
          ),
        ],
      )),
    );
  }
}

class SelectNamePage extends StatefulWidget {
  final StringCallback name_cb;
  final StringCallback category_cb;
  SelectNamePage({required this.name_cb, required this.category_cb});

  @override
  State<SelectNamePage> createState() =>
      SelectNamePageState(name_cb: this.name_cb, category_cb: this.category_cb);
}

class SelectNamePageState extends State<SelectNamePage> {
  final StringCallback name_cb;
  final StringCallback category_cb;
  String name = '';
  String category = '';

  SelectNamePageState({required this.name_cb, required this.category_cb});

  @override
  Widget build(BuildContext context) {
    List<String> radio_values = ['Mother', 'Father', 'Cat', 'Dog'];

    ListTile create_radio_btn(int idx) {
      return ListTile(
        title: Text(radio_values[idx]),
        leading: Radio(
            value: radio_values[idx],
            groupValue: category,
            onChanged: (String? _value) {
              setState(() {
                category = radio_values[idx];
              });
            }),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('SlutOpgaveHentnavnOgFarve')),
      body: Center(
          child: Column(children: <Widget>[
        const Text('Enter the name of your...'),
        create_radio_btn(0),
        create_radio_btn(1),
        create_radio_btn(2),
        create_radio_btn(3),
        TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
            ),
            onChanged: (String value) {
              setState(() {
                name = value;
              });
            }),
        TextButton(
          onPressed: () {
            name_cb(name);
            category_cb(category);
            Navigator.pop(context);
          },
          child: Text('SEND'),
        ),
      ])),
    );
  }
}
