import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Découverte Flutter'),
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
  int _counter = 0;
  int currentPageIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: <Widget>[
        ListView(
          children: [
            Image.asset(
              'images/image.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.scaleDown,
            ),
            Image.network(
              'https://www.powertrafic.fr/wp-content/uploads/2023/04/image-ia-exemple.png',
              width: 200,
              height: 200,
              fit: BoxFit.scaleDown,
            ),
            Column(
              children: [
                const Text(
                  'Nombre:',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 26,
                  ),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            )
          ],
        ),
        Container(
          color: Colors.green,
          width: double.infinity,
          height: double.infinity,
          child: const Center(child: Text('Page suivante')),
        ),
        Container(
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          child: const Center(child: Text('Paramètres')),
        ),
      ][currentPageIndex],
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: _decrementCounter,
                child: const Icon(Icons.remove),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          NavigationDestination(
            icon: Icon(Icons.start),
            label: "Page suivante",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings),
            label: "Paramètres",
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
