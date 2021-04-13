import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:baidu_mob_stat/baidu_mob_stat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _eventStartEndButtonSelected = false;
  String _deviceCuid = "";
  String _testDeviceId = "";

  Future _getDeviceCuid() async {
    String cuid = await BaiduMobStatFlutter.getDeviceCuid();
    setState(() {
      _deviceCuid = cuid;
    });
  }

  Future _getTestDeviceId() async {
    String id = await BaiduMobStatFlutter.getTestDeviceId();
    setState(() {
      _testDeviceId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: const Text('logEvent'), 
                onPressed: () {
                  BaiduMobStatFlutter.logEvent('Event1', {'k1': 'v1', 'k2': 'v2'});
                },
              ),
              RaisedButton(
                child: const Text('logDurationEvent'), 
                onPressed: () {
                  BaiduMobStatFlutter.logDurationEvent('Event2', 3000, {'k1': 'v1'});
                },
              ),
              RaisedButton(
                child: Text(_eventStartEndButtonSelected ? 'eventEnd' : 'eventStart'),
                color: _eventStartEndButtonSelected ? Colors.green : Colors.grey[300],
                onPressed: () {
                  setState(() {            
                    _eventStartEndButtonSelected = !_eventStartEndButtonSelected;
                  });
                  if (_eventStartEndButtonSelected) {
                    BaiduMobStatFlutter.eventStart('Event3');
                  } else {
                    BaiduMobStatFlutter.eventEnd('Event3', {'k1': 'v1'});
                  }
                },
              ),
              RaisedButton(
                child: const Text('Open new page'),
                onPressed: () {
                  BaiduMobStatFlutter.pageStart('AnotherPage');
                },
              ),
              RaisedButton(
                child: const Text('Close new page'),
                onPressed: () {
                  BaiduMobStatFlutter.pageEnd('AnotherPage');
                },
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    child: const Text('getDeviceCuid'),
                    onPressed: _getDeviceCuid,
                  ),
                  Text(_deviceCuid),
                ],
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    child: const Text('getTestDeviceId'),
                    onPressed: _getTestDeviceId,
                  ),
                  Text(_testDeviceId),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

