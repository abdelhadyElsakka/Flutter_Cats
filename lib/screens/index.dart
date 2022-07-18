import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imrich/screens/details.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserScreenState();
  }
}

class _UserScreenState extends State<UsersScreen> {
  late Future<List<Cat>> cat;

  @override
  void initState() {
    super.initState();
    cat = GetData().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: cat,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var cats = (snapshot.data as List<Cat>);

              return ListView.builder(
                  itemCount: cats.length,
                  itemBuilder: (context, index) => CatListItem(cats[index]));
            } else if (snapshot.hasError) {
              debugPrint('cats:$snapshot');
              return const Center(child: Text('Error'));
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class CatListItem extends StatelessWidget {
  var cat;
  CatListItem(this.cat);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CatDetails(cat)))},
      child:SizedBox (
        height: MediaQuery.of(context).size.height / 5,
        child: Center(
            child: Card(
              child: Row(
                children: [
                  Image.network(cat.picture),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(cat.title),
                      Text(cat.content),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}


class Cat {
  String title;
  String picture;
  String content;
  String id;

  Cat(
      this.title,
      this.picture,
      this.content,
      this.id,
      );

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      json['title'],
      json['picture'],
      json['content'],
      json['id'],
    );
  }
}




class GetData {
  Future<List<Cat>> fetchUsers() async {
    var response = await http.get(Uri.parse('https://62d4154fcd960e45d452f790.mockapi.io/api/article'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var list = (jsonResponse as List);
      var newList = list.map((item) => Cat.fromJson(item)).toList();
      return newList;
    } else {
      throw Exception('Can not fetch Cats');
    }
  }
}

