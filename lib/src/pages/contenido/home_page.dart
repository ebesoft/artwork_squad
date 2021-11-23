import 'package:artwork_squad/src/pages/utils/bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: ListView(
        //children: Container(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.black87,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('../assets/avatar/avatar1.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: const Text('Card title 1',
                      style: TextStyle(color: Colors.blueAccent)),
                  subtitle: Text(
                    'Secondary Text',
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.favorite_outline_sharp),
                        color: Colors.white,
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.comment_bank_outlined),
                        color: Colors.white,
                        onPressed: () {}),
                  ],
                ),
                Image.asset('../assets/arte/art1.jpg'),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.black87,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('../assets/avatar/avatar3.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: const Text('Card title 2',
                      style: TextStyle(color: Colors.blueAccent)),
                  subtitle: Text(
                    'Secondary Text',
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.favorite_sharp),
                        color: Colors.red,
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.comment_bank_outlined),
                        color: Colors.white,
                        onPressed: () {}),
                  ],
                ),
                Image.asset('../assets/arte/art2.webp'),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.black87,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('../assets/avatar/avatar2.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: const Text('Card title 3',
                      style: TextStyle(color: Colors.blueAccent)),
                  subtitle: Text(
                    'Secondary Text',
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.favorite_sharp),
                        color: Colors.red,
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.comment_bank_outlined),
                        color: Colors.white,
                        onPressed: () {}),
                  ],
                ),
                Image.asset('../assets/arte/art4.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
