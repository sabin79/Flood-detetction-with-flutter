import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async'; 


class Device extends StatefulWidget {
  const Device({super.key});

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  var _value;
  var _value2;
  var _value3;
  var _value4;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      _getRain();
      _getValue1();
      _getValue2();
      _getValue3();
    });
  }

  Future<void> _getRain() async {
    final response = await http.get(Uri.parse(
        'https://blynk.cloud/external/api/get?token=S8RFyU1Y1v546c1OXqYHNCdOdxFkmvCh&v0'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _value = data;
      });
    }
  }

  Future<void> _getValue1() async {
    final response = await http.get(Uri.parse(
        'https://blynk.cloud/external/api/get?token=S8RFyU1Y1v546c1OXqYHNCdOdxFkmvCh&v2'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _value2 = data;
      });
    }
  }

  Future<void> _getValue2() async {
    final response = await http.get(Uri.parse(
        'https://blynk.cloud/external/api/get?token=S8RFyU1Y1v546c1OXqYHNCdOdxFkmvCh&v3'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _value3 = data;
      });
    }
  }

  Future<void> _getValue3() async {
    final response = await http.get(Uri.parse(
        'https://blynk.cloud/external/api/get?token=S8RFyU1Y1v546c1OXqYHNCdOdxFkmvCh&v4'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _value4 = data;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 163, 55, 127),
          title: Text(
            'Rain Device',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assects/raain.jpg',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Text(
                        "Rain Sensor 1:    $_value",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Text(
                        "Rain Sensor 2:    $_value2",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                      ),
                      Text(
                        "Rain Sensor 3: $_value3",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                      Text(
                        "Rain Sensor 4: $_value3",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
