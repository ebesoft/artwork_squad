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
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('../assets/avatar/avatar1.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: const Text('Card title 1'),
                  subtitle: Text('Secondary Text'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.'),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.favorite_outline_sharp),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.comment_bank_outlined),
                        onPressed: () {}),
                  ],
                ),
                Image.asset('../assets/arte/art1.jpg'),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('../assets/avatar/avatar3.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: const Text('Card title 2'),
                  subtitle: Text('Secondary Text'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.'),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.favorite_sharp), onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.comment_bank_outlined),
                        onPressed: () {}),
                  ],
                ),
                Image.asset('../assets/arte/art2.webp'),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('../assets/avatar/avatar2.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: const Text('Card title 3'),
                  subtitle: Text('Secondary Text'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.'),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.favorite_sharp), onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.comment_bank_outlined),
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
