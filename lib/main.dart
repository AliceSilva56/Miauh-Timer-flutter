import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const TelaPrincipal()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroud.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/hora_miauh.png', width: 308, height: 250),
                const SizedBox(height: 12),
                const Text(
                  'Miauh',
                  style: TextStyle(
                    fontFamily: 'AmsterdamOne',
                    fontSize: 65,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 3),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Timer',
                  style: TextStyle(
                    fontFamily: 'AmsterdamOne',
                    fontSize: 66,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final TextEditingController _date1 = TextEditingController();
  final TextEditingController _time1 = TextEditingController();
  final TextEditingController _date2 = TextEditingController();
  final TextEditingController _time2 = TextEditingController();

  String? _resultado;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _date1.text = _formatDate(now);
    _time1.text = _formatTime(now);
    _date2.text = _formatDate(now);
    _time2.text = _formatTime(now);
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  String _formatTime(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  Future<void> _pickDate(TextEditingController controller) async {
    final parts = controller.text.split('/');
    final initial = parts.length == 3
        ? DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]))
        : DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = _formatDate(picked);
    }
  }

  Future<void> _pickTime(TextEditingController controller) async {
    final parts = controller.text.split(':');
    final initial = parts.length == 2
        ? TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]))
        : TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (picked != null) {
      controller.text =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    }
  }

  void _calcular() {
    try {
      final d1 = _parseDateTime(_date1.text, _time1.text);
      final d2 = _parseDateTime(_date2.text, _time2.text);
      final diff = d2.difference(d1);
      final totalMinutes = diff.inMinutes;
      final days = totalMinutes ~/ (60 * 24);
      final hours = (totalMinutes % (60 * 24)) ~/ 60;
      final minutes = totalMinutes % 60;
      setState(() {
        _resultado = '$days Dias, $hours Horas e $minutes Minutos';
      });
    } catch (_) {
      setState(() {
        _resultado = null;
      });
    }
  }

  DateTime _parseDateTime(String date, String time) {
    final dp = date.split('/');
    final tp = time.split(':');
    final day = int.parse(dp[0]);
    final month = int.parse(dp[1]);
    final year = int.parse(dp[2]);
    final hour = int.parse(tp[0]);
    final minute = int.parse(tp[1]);
    return DateTime(year, month, day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Fixed design canvas like Android XML (516dp width). Scale down on small screens.
          const designW = 516.0;
          final availableW = constraints.maxWidth;
          final scale = availableW < designW ? availableW / designW : 1.0;

          double px(double v) => v * scale;

          return Container(
            color: Colors.white,
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: SizedBox(
                width: px(designW),
                height: px(800),
                child: Stack(
                  children: [
                    // cards background (516x659dp)
                    Positioned(
                      top: 0,
                      left: 0,
                      width: px(516),
                      height: px(659),
                      child: Image.asset('assets/images/cards.png', fit: BoxFit.contain),
                    ),

                    // cat (161x155dp) with 4dp margin top, centered horizontally
                    Positioned(
                      top: px(4),
                      left: (px(516) - px(161)) / 2,
                      width: px(161),
                      height: px(155),
                      child: Image.asset('assets/images/cat.png', fit: BoxFit.contain),
                    ),

                    // cat paws (approx width 280dp) at 144dp top
                    Positioned(
                      top: px(144),
                      left: (px(516) - px(280)) / 2,
                      width: px(280),
                      child: Image.asset('assets/images/catpaws.png', fit: BoxFit.contain),
                    ),

                    // Titulos 
                    Positioned(
                      top: px(160),
                      left: px(716 * 0.301) - px(80),
                      child: const Text('Hora de inicio', style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                    Positioned(
                      top: px(164),
                      left: px(516 * 0.727) - px(60),
                      child: const Text('Hora final', style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),

                    // Left labels
                    Positioned(
                      top: px(200),
                      left: px(516 * 0.2) - px(20),
                      child: const Text('Data', style: TextStyle(fontSize: 15)),
                    ),
                    Positioned(
                      top: px(246),
                      left: px(516 * 0.2) - px(25),
                      child: const Text('Tempo', style: TextStyle(fontSize: 15)),
                    ),

                    // Right labels
                    Positioned(
                      top: px(199),
                      left: px(516 * 0.8) - px(20),
                      child: const Text('Data', style: TextStyle(fontSize: 15)),
                    ),
                    Positioned(
                      top: px(250),
                      left: px(516 * 0.8) - px(25),
                      child: const Text('Tempo', style: TextStyle(fontSize: 15)),
                    ),

                    // Inputs left (width ~180dp)
                    Positioned(
                      top: px(215), // posição vertical
                      left: px(980 * 0.2) - px(150), // posição horizontal
                      width: px(150), // largura
                      child: TextField(
                        controller: _date1, // controlador do campo
                        readOnly: true, // campo somente leitura
                        decoration: const InputDecoration(hintText: 'Date'), // texto de ajuda
                        onTap: () => _pickDate(_date1), // ao clicar, abre o calendário
                      ),
                    ),
                    Positioned(
                      top: px(320), // posição vertical
                      left: px(1000 * 0.2) - px(90), // posição horizontal
                      width: px(150), // largura
                      child: TextField(
                        controller: _time1, // controlador do campo
                        readOnly: true, // campo somente leitura
                        decoration: const InputDecoration(hintText: 'Time'), // texto de ajuda
                        onTap: () => _pickTime(_time1), // ao clicar, abre o calendário
                      ),
                    ),

                    // Inputs right
                    Positioned(
                      top: px(219), // posição vertical
                      left: px(516 * 0.8) - px(100), // posição horizontal
                      width: px(150), // largura
                      child: TextField(
                        controller: _date2, // controlador do campo
                        readOnly: true, // campo somente leitura
                        decoration: const InputDecoration(hintText: 'Date'), // texto de ajuda
                        onTap: () => _pickDate(_date2), // ao clicar, abre o calendário
                      ),
                    ),
                    Positioned(
                      top: px(320),
                      left: px(516 * 0.8) - px(90),
                      width: px(150),
                      child: TextField(
                        controller: _time2,
                        readOnly: true,
                        decoration: const InputDecoration(hintText: 'Time'),
                        onTap: () => _pickTime(_time2),
                      ),
                    ),

                    // 'tres.png' (behind text) at ~528dp top
                    if (_resultado != null)
                      Positioned(
                        top: px(528),
                        left: (px(516) - px(240)) / 2,
                        width: px(240),
                        height: px(221),
                        child: Image.asset('assets/images/tres.png', fit: BoxFit.contain),
                      ),

                    // Button at ~508dp
                    Positioned(
                      top: px(508),
                      left: (px(516) - px(200)) / 2,
                      width: px(200),
                      height: px(40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF005383),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(40),
                        ),
                        onPressed: _calcular,
                        child: const Text('Calcular'),
                      ),
                    ),

                    // Result texts on top of 'tres.png'
                    if (_resultado != null)
                      Positioned(
                        top: px(644),
                        left: (px(516) - px(200)) / 2,
                        child: const Text('A diferença é de:', style: TextStyle(fontSize: 16)),
                      ),
                    if (_resultado != null)
                      Positioned(
                        top: px(672),
                        left: (px(516) - px(260)) / 2,
                        child: Row(
                          children: [
                            const Icon(Icons.pets),
                            const SizedBox(width: 8),
                            Text(_resultado!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
