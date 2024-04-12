import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget {
  WidgetApp({Key? key}) : super(key: key);
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp> {
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();
  List<String> _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItems = [];
  String _buttonText = '더하기';

  @override
  void initState() {
    super.initState();

    for (var item in _buttonList) {
      _dropDownMenuItems.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }
    if (_dropDownMenuItems.isNotEmpty) {
      _buttonText = _dropDownMenuItems[0].value!;
    } else {
      _buttonText = '더하기';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  '결과 : $sum',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: value1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: value2,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add),
                      Text('더하기'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () {
                    // 버튼이 눌리면 수행할 동작
                    setState(() {
                      var value1Int = double.parse(value1.value.text);
                      var value2Int = double.parse(value2.value.text);
                      var result;
                      if (_buttonText == '더하기') {
                        result = value1Int + value2Int;
                      } else if (_buttonText == '빼기') {
                        result = value1Int - value2Int;
                      } else if (_buttonText == '곱하기') {
                        result = value1Int * value2Int;
                      } else if (_buttonText == '나누기') {
                        result = value1Int / value2Int;
                      }
                      sum = '$result';
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: DropdownButton<String>(
                  items: _dropDownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _buttonText = value!;
                    });
                  },
                  value: _buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
