import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = 'hello';
  List<dynamic> data = []; // data 필드를 빈 리스트로 초기화

  @override
  void initState() {
    super.initState();
    // data를 이미 초기화했으므로, 여기서는 초기화 코드가 필요하지 않습니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Example'),
      ),
      body: Container(
        child: Center(
          child: data.length == 0
            ? Text(
            '데이터가 없습니다.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
          : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  child: Column(
                    children: [
                      Text(data[index]['title'].toString()),
                      Text(data[index]['authors'].toString()),
                      Text(data[index]['sale_price'].toString()),
                      Text(data[index]['status'].toString()),
                      Image.network(
                        data[index]['thumbnail'],
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: data.length),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getJSONData();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<void> getJSONData() async {
    var url = Uri.parse('https://dapi.kakao.com/v3/search/book?target=title&query=doit');
    try {
      final response = await http.get(url, headers: {"Authorization": "KakaoAK 68ab1b856c9c72d2c9056365032b5fdb"});
      if (response.statusCode == 200) {
        final dataConvertedToJSON = json.decode(response.body);
        final List<dynamic> result = dataConvertedToJSON['documents'];
        setState(() {
          data.addAll(result);
        });
      } else {
        setState(() {
          result = 'Failed to fetch data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error fetching data: $e';
      });
    }
  }
}
