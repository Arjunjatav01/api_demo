import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
      const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listofFacts;

  Future fetchData() async {
    http.Response response;
    response = await http.get(
      Uri.parse(
        'https://www.thegrowingdeveloper.org/apiview?id=2',
      ),
    );
    if (response.statusCode == 200) {
      setState(
        () {
          mapResponse = json.decode(response.body);
          listofFacts = mapResponse!['facts'];
        },
      );
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'API DEMO',
        ),
        backgroundColor: Colors.red[900],
      ),
      body: mapResponse == null
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    mapResponse!['category'].toString(),
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.network(
                              listofFacts![index]['image_url'],
                            ),
                            Text(
                              listofFacts![index]['title'].toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              listofFacts![index]['description'].toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: listofFacts == null ? 0 : listofFacts!.length,
                  )
                ],
              ),
            ),
    );
  }
}
