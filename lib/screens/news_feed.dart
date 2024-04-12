import 'package:MICEconnect/dto/news.dart';
import 'package:MICEconnect/screens/create.dart';
import 'package:flutter/material.dart';
import 'package:MICEconnect/services/data_service.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final Future<List<News>> _news = DataService.fetchNews();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata - Data Mahasiswa'),
        backgroundColor: Color.fromARGB(255, 56, 187, 231),
      ),
      body: Center(
        child: FutureBuilder<List<News>>(
          future: _news,
          builder: ((context, snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: InkWell(
                      child: Card(
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              width: 400,
                              child: Image.network(
                                post.photo,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    post.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    post.body,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => InputApi(),));
        },
        child: Icon(Icons.ac_unit_sharp),
      ),
    );
  }
}