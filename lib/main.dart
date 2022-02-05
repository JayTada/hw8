import 'dart:math';

import 'package:flutter/material.dart';

import 'game.dart';
import 'gn.dart';

void main() {
  const app = MyApp();
  runApp(app);
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // callback method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GN',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class _HomePageState extends State<HomePage> {

  var ran = Rd();
  String _number = '';
  String _status = 'ทายตัวเลข 1 ถึง 100';
  int count = 0 ;





  @override
  Widget build(BuildContext context) {


    var gamerandom = game(ran.answers);
    var rrand = ran.answers.toString();
    print('เฉลย: ' + rrand.toString());


    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade100,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 90.0),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GUESS',
                            style: TextStyle(
                              fontSize: 36.0,
                              color: Colors.deepPurple,)),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.deepPurpleAccent,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$_number',
                  style: TextStyle(fontSize: 50.0, color: Colors.deepPurple),
                ),
              ),
              //บอกสถานะ//
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(


                  '$_status',

                  style: TextStyle(fontSize: 25.0, color: Colors.deepPurpleAccent),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 1; i <= 3; i++) buildButton(num: i),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 4; i <= 6; i++) buildButton(num: i),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 7; i <= 9; i++) buildButton(num: i),
                    ],
                  )),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {
                            print('close');
                            setState(() {
                              _number = _number.substring(0, 0);
                            });
                          },
                          child: Icon(
                            Icons.disabled_by_default, // รูปไอคอน
                            size: 25.0,
                          )),
                    ),
                    buildButton(num: 0),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: OutlinedButton(
                          onPressed: () {
                            print('backspace');
                            setState(() {
                              _number = _number.substring(
                                  0, _number.length - 1);
                            });
                          },
                          child: Icon(
                            Icons.backspace,
                            // รูปไอคอน
                            size: 25.0,
                          )),
                    ),
                  ],
                ),
              ),





              Padding(
                padding: const EdgeInsets.all(16.0),

                child: ElevatedButton(

                  child: Text('GUESS'),
                  onPressed: () {

                    var guess = int.tryParse(_number);


                    if (guess == null) {
                      setState(() {
                        _status =
                        'กรอกข้อมูลไม่ถูกต้อง กรอกเฉพาะตัวเลขเท่านั้น';
                        _number = _number.substring(0, 0);
                      });

                      return;
                    }
                    else {
                      var result = gamerandom.doGuess(guess);
                      if (result == 1) {
                        setState(() {
                          _status = '$guess : มากเกินไป ลองใหม่อีกครั้ง!';
                          _number = _number.substring(0, 0);
                        });
                        print('$guess มากเกินไป ลองใหม่อีกครั้ง!');
                        count++;
                      } else if (result == -1) {
                        setState(() {
                          _status = '$guess : น้อยเกินไป ลองใหม่อีกครั้ง!';
                          _number = _number.substring(0, 0);
                        });
                        print('$guess น้อยเกินไป ลองใหม่อีกครั้ง!');
                        count++;
                      } else if (result == 0) {
                        setState(() {
                          count++;
                          _status =
                          'ถูกต้อง 🚀 คุณทายทั้งหมด $count ครั้ง';


                        });
                        print(


                            '$guess ถูกต้อง 🚀 \n คุณทายทั้งหมด $count ครั้ง');



                      }
                    }


                    //_showOkDialog(context, 'RESULT', message);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildButton({int? num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton(
          onPressed: () {
            setState((){
              _number = ' $_number$num';
            });
          },
          child: Text('$num')),
    );
  }
}