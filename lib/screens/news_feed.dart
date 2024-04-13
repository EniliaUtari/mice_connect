import 'package:flutter/material.dart';
import 'package:mice_connect/dto/news.dart';
import 'package:mice_connect/screens/create.dart';
import 'package:mice_connect/screens/edit_news.dart';
import 'package:mice_connect/services/data_service.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final Future<List<News>> _news = DataService.fetchNews();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata - Data Mahasiswa'),
        backgroundColor: const Color.fromARGB(255, 56, 187, 231),
      ),
      body: Center(
        child: FutureBuilder<List<News>>(
          future: _news,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: InkWell(
                      onTap: () {
                        // Navigasi untuk membuka layar edit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNewsScreen(news: post),
                          ),
                        );
                      },
                      onLongPress: () {
                        // Hapus data
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Data'),
                            content: const Text('Are you sure you want to delete this data?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Hapus data
                                  DataService.deleteNews(post.id);
                                  Navigator.of(context).pop();
                                  setState(() {
                                    // Refresh halaman setelah menghapus data
                                  });
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
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
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        post.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              // Implementasi untuk edit data di sini
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EditNewsScreen(news: post),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // Implementasi untuk hapus data di sini
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    post.body,
                                    style: const TextStyle(
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
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 56, 187, 231),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InputApi()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white
      ),
    ),
    );
  }
}
