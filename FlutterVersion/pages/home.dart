import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


List symbols = ['а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р',
  'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я', 'a', 'b', 'c', 'd', 'e',
  'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
  'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', ',', ';', ':', '-',
  '_', ' ', '!', '@', '#', '\$', '%', '^', '&', '*', '(', ')', '+', '=', '\"', '№', '~', '?',
  '\\', '/', '|', '[', ']', '{', '}', '`', '\'', '<', '>']; // список со всеми элементами
final TextEditingController _controller = new TextEditingController();
final TextEditingController _controller2 = new TextEditingController();
late dynamic keyWord = ' '; // переменная, в которой хранится ключ
late dynamic text = ' '; // переменная, в которой хранится текст (input)
late dynamic res; // переменная, в которой хранится резульат (EN/DE)
late dynamic a4; // переменная, содержащая код элемента
late dynamic m;  // индекс символа из ключевого слова
late dynamic n;  // 1 символ из кода символа
late dynamic f;
var d = 0; // индекс символа из введённого символа
var k = 0;
var z = 0;
var operation = 0;
var m1 = 0; // индекс символа из введённого символа
var c = 0;  // код одного символа




class _HomeState extends State<Home> {
  get l => null;

  get txt => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('QuadCode'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {

            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                title: Row(
                  children: [
                    Text('Инструкция'),
                  ],
                ),
                content:
                Text('Здесь будет отображаться инструкция, например,'
                    'в виде GIF или JPEG файла, но пока что тут этот текст.'),
                actions: [
                  ElevatedButton(onPressed: () {

                    Navigator.of(context).pop();

                  },
                      child: Text('OK'))
                ],
              );
            });

          }, icon: Icon(Icons.quiz))
        ],
      ),
      body: Column(
        children: [

          Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),


          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _controller,
                  onChanged: (input){
                    setState(() {
                      keyWord = input;
                    });
                  },
                  onSubmitted: (String str){
                    setState(() {
                      keyWord = str;
                    });
                  },
                  maxLength: 4,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Key-word',
                    // errorText: 'Inappropriate Key-word',
                    suffixIcon: Icon(
                      Icons.vpn_key_rounded,
                    ),
                  ),
                )
              ],
            ),
          ),


          Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),


          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (input){
                    setState(() {
                      text = input;
                    });
                  },
                  controller: _controller2,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Text',
                    suffixIcon: Icon(
                      Icons.text_snippet_rounded,
                    ),
                  ),
                )
              ],
            ),
          ),

          Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
              ElevatedButton(onPressed: () async {

                setState(() {
                  var clear = _controller.text = '';
                  var clear2 = _controller2.text = '';
                });

                var l = (text.length) as int;
                for( var i = l ; i >= 1; i-- ){
                  if(symbols.contains(text[d])) {
                    var f = symbols.indexOf(text[d]);
                    a4 = '';
                    if(f == 0){
                      a4 = '0';
                      while(f > 0){
                        a4 = (f % 4).toString() + a4.toString();
                        f = f ~/ 4;
                      }
                        a4 = '$a4';
                    }
                  }
                else{
                    a4 += '1123';
                  }
                while(a4.length != 4) {
                  a4 = '0' + a4;
                }
                  for( var j = 4 ; j >= 1; j-- ){
                    res += (keyWord[(a4[z]) as int]);
                    res.whenComplete((){
                      setState(() {});
                    });
                    z += 1;
                  }
                  z = 0;
                  d += 1;
                }






                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Result'),
                        IconButton(onPressed: () {

                          Navigator.of(context).pop();

                        }, icon: Icon(Icons.close),),
                      ],
                    ),
                    content: Text(res),
                    actions: [
                      ElevatedButton(onPressed: () {
                        Clipboard.setData(ClipboardData(text: res));

                      },
                          child: Text('Copy'))

                    ],
                    );
                });
              },
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size.fromWidth(100))),
                  child: Text('Encode')),

              Padding(padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
              ElevatedButton(onPressed: () {


                setState(() {
                  res = 'DECODE. Key-word: $keyWord. Text: $text';
                  var clear = _controller.text = '';
                  var clear2 = _controller2.text = '';
                });

                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Result'),
                        IconButton(onPressed: () {

                          Navigator.of(context).pop();

                        }, icon: Icon(Icons.close),),
                      ],
                    ),
                    content: Text(res),
                    actions: [
                      ElevatedButton(onPressed: () {
                        Clipboard.setData(ClipboardData(text: res));

                      },
                          child: Text('Copy'))

                    ],
                  );
                });
              },
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size.fromWidth(100))),
                  child: Text('Decode')),
            ],
          ),






        ],
      ),

    );

  }
}
