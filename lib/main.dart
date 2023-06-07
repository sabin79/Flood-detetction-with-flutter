import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

void main(List<String> args) {
  runApp(fire());
}

class fire extends StatefulWidget {
  const fire({super.key});

  @override
  State<fire> createState() => _fireState();
}

class _fireState extends State<fire> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fire Dretection',
      home: Hello(),
    );
  }
}

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  var _value;
  var _rain;

  String? _firestatus;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (_) {
      _getValue();
      _getRain();
    });
  }

  Future<void> _getValue() async {
    final response = await http.get(Uri.parse(
        'https://blynk.cloud/external/api/get?token=r0krRBF8CTGGK46iukE6o2hNuitZOul0&v0'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _value = data;
      });
      if ((_value ?? 0) <= 5) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            /// This code is creating an alert dialog box with a title and content message to warn the
            /// user about the possibility of flooding due to high water levels. It also includes an
            /// "OK" button that dismisses the dialog box when clicked.
            return AlertDialog(
              title: Text('Fire Alert'),
              content: Text(
                  'Fire has been detected. \n Please evacuate immediately . \n Call emergency services.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
      setState(() {
        _firestatus = (_value ?? 0) <= 5 ? 'Alert it fire' : 'Gas is high';
      });
    }
  }

  Future<void> _getRain() async {
    final response = await http.get(Uri.parse(
        'https://blynk.cloud/external/api/get?token=r0krRBF8CTGGK46iukE6o2hNuitZOul0&v1'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _rain = data;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Fire Detection",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Sabnam Khadka"),
              accountEmail: Text("ksabnam777@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("images/ai.jpg"),
                maxRadius: 50,
              ),
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            ListTile(
              title: Text("home"),
              leading: Icon(Icons.home_outlined),
              onTap: () {},
            ),
            ListTile(
              title: Text("Reports"),
              leading: Icon(Icons.report_gmailerrorred_sharp),
              onTap: () {},
            ),
            ListTile(
              title: Text("Setting"),
              leading: Icon(Icons.settings_applications_sharp),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assects/splash.jpg"), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    "Gas:  $_value ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Fire: $_rain ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  "Display: $_firestatus ",
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text('Call 101'),
              onPressed: () {
                launch("tel: 101");
              },
            )
          ],
        ),
      ),
    );
  }
}
