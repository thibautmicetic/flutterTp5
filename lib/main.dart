import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:math';

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
  int maxValue = 1;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://www.ayura-co.jp/wp-content/uploads/2021/09/Kavinsky-Nightcall-Drive-Original-Movie-Soundtrack-Official-Audio.mp4?_=1',
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    myController.dispose();
  }

  void _incrementCounter() {
    setState(() {
      if (currentPageIndex == 0) {
        _counter++;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (currentPageIndex == 0) {
        _counter--;
      }
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                        hintText: 'Nombre max',
                        prefixIcon: Icon(Icons.calculate),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: Colors.deepPurple,
                            strokeAlign: 50,
                            style: BorderStyle.solid,
                          ),
                        )),
                    keyboardType: TextInputType.number,
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        int random = 1;
                        if (myController.text != '' &&
                            int.parse(myController.text) >= 1) {
                          random =
                              Random().nextInt(int.parse(myController.text));
                        }
                        _counter = random;
                      });
                    },
                    child: const Text('Générer un nombre aléatoire'),
                  ),
                )
              ],
            )
          ],
        ),
        Container(
          color: Colors.green,
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
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
          Padding(
            padding: const EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (currentPageIndex == 1) {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    }
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
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
