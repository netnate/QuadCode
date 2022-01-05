import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}



final TextEditingController _controller = new TextEditingController();
final TextEditingController _controller2 = new TextEditingController();
late dynamic keyWord = ' '; // переменная, в которой хранится ключ
late dynamic text = ' '; // переменная, в которой хранится текст (input)
dynamic res = ''; // переменная, в которой хранится резульат (EN/DE)
late dynamic a4; // переменная, содержащая код элемента
late dynamic m;  // индекс символа из ключевого слова
late dynamic n;  // 1 символ из кода символа
late int f;
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
                Text('Для того, чтобы зашифровать сообщение, введите ключевое слово для шифрования '
                    'в первое поле для ввода, текст для шифрования во второе поле, '
                    'после чего нажмите кнопку "Encode". Для того, чтобы расшифровать сообщение, введите '
                    'ключевое слово, с которым оно было закодировано в поле для вода "Key-word", а '
                    'само сообщение в поле "Text", затем нажмите кнопку "Decode". '
                    'Ключевое слово должно содержать 4 различных символа. Текст может содержать '
                    'любое количество символов. Если символ в тексте не будет опознан, ему присвоится '
                    'код символа "?"'),
                actions: [
                  ElevatedButton(onPressed: () {

                    Navigator.of(context).pop();

                  },
                      child: Text('OK'))
                ],
              );
            });

          }, icon: Icon(Icons.quiz)),


          IconButton(onPressed: () {
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                title: Row(
                  children: [
                    Text('Разработчик'),
                  ],
                ),
                content:
                    Container(
                        height: 70,
                      child:
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('Вершинин Илья',
                                    style: TextStyle(fontWeight: FontWeight. bold),),
                                ],
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0, 4, 0, 0)),
                              Row(
                                children: [
                                  Text('E-mail: ilyavershinin2006@gmail.com')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Telegram: https://t.me/NeT_Nate')
                                ],
                              )
                            ],
                          )
                    ),
                actions: [
                ],
              );
            });
          }, icon: Icon(Icons.code)),
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
                    content: Text(encode(keyWord, text)),
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
                  // res = 'DECODE. Key-word: $keyWord. Text: $text';
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
                    content: Text(decode(keyWord, text)),
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


  encode(keyWord, text){
    late String a1 = keyWord[0];
    late String b1 = keyWord[1];
    late String c1 = keyWord[2];
    late String d1 = keyWord[3];
    late int r = 0;
    late dynamic res = ''; // переменная, в которой хранится резульат (EN/DE)

    var w = {
      'а' : a1+a1+a1+a1, 'б' : a1+a1+a1+b1, 'в' : a1+a1+a1+c1, 'г' : a1+a1+a1+d1, 'д' : a1+a1+b1+a1,
      'е' : a1+a1+b1+b1, 'ё' : a1+a1+b1+c1, 'ж' : a1+a1+b1+d1, 'з' : a1+a1+c1+a1, 'и' : a1+a1+c1+b1,
      'й' : a1+a1+c1+c1, 'к' : a1+a1+c1+d1, 'л' : a1+a1+d1+a1, 'м' : a1+a1+d1+b1, 'н' : a1+a1+d1+c1,
      'о' : a1+a1+d1+d1, 'п' : a1+b1+a1+a1, 'р' : a1+b1+a1+b1, 'с' : a1+b1+a1+c1, 'т' : a1+b1+a1+d1,
      'у' : a1+b1+b1+a1, 'ф' : a1+b1+b1+b1, 'х' : a1+b1+b1+c1, 'ц' : a1+b1+b1+d1, 'ч' : a1+b1+c1+a1,
      'ш' : a1+b1+c1+b1, 'щ' : a1+b1+c1+c1, 'ъ' : a1+b1+c1+d1, 'ы' : a1+b1+d1+a1, 'ь' : a1+b1+d1+b1,
      'э' : a1+b1+d1+c1, 'ю' : a1+b1+d1+d1, 'я' : a1+c1+a1+a1, 'a' : a1+c1+a1+b1, 'b' : a1+c1+a1+c1,
      'c' : a1+c1+a1+d1, 'd' : a1+c1+b1+a1, 'e' : a1+c1+b1+b1, 'f' : a1+c1+b1+c1, 'g' : a1+c1+b1+d1,
      'h' : a1+c1+c1+a1, 'i' : a1+c1+c1+b1, 'j' : a1+c1+c1+c1, 'k' : a1+c1+c1+d1, 'l' : a1+c1+d1+a1,
      'm' : a1+c1+d1+b1, 'n' : a1+c1+d1+c1, 'o' : a1+c1+d1+d1, 'p' : a1+d1+a1+a1, 'q' : a1+d1+a1+b1,
      'r' : a1+d1+a1+c1, 's' : a1+d1+a1+d1, 't' : a1+d1+b1+a1, 'u' : a1+d1+b1+b1, 'v' : a1+d1+b1+c1,
      'w' : a1+d1+b1+d1, 'x' : a1+d1+c1+a1, 'y' : a1+d1+c1+b1, 'z' : a1+d1+c1+c1, '0' : a1+d1+c1+d1,
      '1' : a1+d1+d1+a1, '2' : a1+d1+d1+b1, '3' : a1+d1+d1+c1, '4' : a1+d1+d1+d1, '5' : b1+a1+a1+a1,
      '6' : b1+a1+a1+b1, '7' : b1+a1+a1+c1, '8' : b1+a1+a1+d1, '9' : b1+a1+b1+a1, '.' : b1+a1+b1+b1,
      ',' : b1+a1+b1+c1, ';' : b1+a1+b1+d1, ':' : b1+a1+c1+a1, '-' : b1+a1+c1+b1, '_' : b1+a1+c1+c1,
      ' ' : b1+a1+c1+d1, '!' : b1+a1+d1+a1, '@' : b1+a1+d1+b1, '#' : b1+a1+d1+c1, '\$' : b1+a1+d1+d1,
      '%' : b1+b1+a1+a1, '^' : b1+b1+a1+b1, '&' : b1+b1+a1+c1, '*' : b1+b1+a1+d1, '(' : b1+b1+b1+a1,
      ')' : b1+b1+b1+b1, '+' : b1+b1+b1+c1, '=' : b1+b1+b1+d1, '"' : b1+b1+c1+a1, '№' : b1+b1+c1+b1,
      '~' : b1+b1+c1+c1, '?' : b1+b1+c1+d1, '\\' : b1+b1+d1+a1, '/' : b1+b1+d1+b1, '|' : b1+b1+d1+c1,
      '[' : b1+b1+d1+d1, ']' : b1+c1+a1+a1, '{' : b1+c1+a1+b1, '}' : b1+c1+a1+c1, '`' : b1+c1+a1+d1,
      '\'' : b1+c1+b1+a1, '<' : b1+c1+b1+b1, '>' : b1+c1+b1+c1,
    };

    for(var i = text.length ; i >= 1; i-- ){
      if (w.containsKey(text[r])) {
        res += w[text[r]];
        r++;
      }
      else{
        res += b1+b1+c1+d1;
        r++;
      }
    }
  return(res);
  }



  decode(keyWord, text){
    late String a1 = keyWord[0];
    late String b1 = keyWord[1];
    late String c1 = keyWord[2];
    late String d1 = keyWord[3];
    late String m = '';
    late int x = 0;
    late dynamic res = ''; // переменная, в которой хранится резульат (EN/DE)

    var w = {
      'а' : a1+a1+a1+a1, 'б' : a1+a1+a1+b1, 'в' : a1+a1+a1+c1, 'г' : a1+a1+a1+d1, 'д' : a1+a1+b1+a1,
      'е' : a1+a1+b1+b1, 'ё' : a1+a1+b1+c1, 'ж' : a1+a1+b1+d1, 'з' : a1+a1+c1+a1, 'и' : a1+a1+c1+b1,
      'й' : a1+a1+c1+c1, 'к' : a1+a1+c1+d1, 'л' : a1+a1+d1+a1, 'м' : a1+a1+d1+b1, 'н' : a1+a1+d1+c1,
      'о' : a1+a1+d1+d1, 'п' : a1+b1+a1+a1, 'р' : a1+b1+a1+b1, 'с' : a1+b1+a1+c1, 'т' : a1+b1+a1+d1,
      'у' : a1+b1+b1+a1, 'ф' : a1+b1+b1+b1, 'х' : a1+b1+b1+c1, 'ц' : a1+b1+b1+d1, 'ч' : a1+b1+c1+a1,
      'ш' : a1+b1+c1+b1, 'щ' : a1+b1+c1+c1, 'ъ' : a1+b1+c1+d1, 'ы' : a1+b1+d1+a1, 'ь' : a1+b1+d1+b1,
      'э' : a1+b1+d1+c1, 'ю' : a1+b1+d1+d1, 'я' : a1+c1+a1+a1, 'a' : a1+c1+a1+b1, 'b' : a1+c1+a1+c1,
      'c' : a1+c1+a1+d1, 'd' : a1+c1+b1+a1, 'e' : a1+c1+b1+b1, 'f' : a1+c1+b1+c1, 'g' : a1+c1+b1+d1,
      'h' : a1+c1+c1+a1, 'i' : a1+c1+c1+b1, 'j' : a1+c1+c1+c1, 'k' : a1+c1+c1+d1, 'l' : a1+c1+d1+a1,
      'm' : a1+c1+d1+b1, 'n' : a1+c1+d1+c1, 'o' : a1+c1+d1+d1, 'p' : a1+d1+a1+a1, 'q' : a1+d1+a1+b1,
      'r' : a1+d1+a1+c1, 's' : a1+d1+a1+d1, 't' : a1+d1+b1+a1, 'u' : a1+d1+b1+b1, 'v' : a1+d1+b1+c1,
      'w' : a1+d1+b1+d1, 'x' : a1+d1+c1+a1, 'y' : a1+d1+c1+b1, 'z' : a1+d1+c1+c1, '0' : a1+d1+c1+d1,
      '1' : a1+d1+d1+a1, '2' : a1+d1+d1+b1, '3' : a1+d1+d1+c1, '4' : a1+d1+d1+d1, '5' : b1+a1+a1+a1,
      '6' : b1+a1+a1+b1, '7' : b1+a1+a1+c1, '8' : b1+a1+a1+d1, '9' : b1+a1+b1+a1, '.' : b1+a1+b1+b1,
      ',' : b1+a1+b1+c1, ';' : b1+a1+b1+d1, ':' : b1+a1+c1+a1, '-' : b1+a1+c1+b1, '_' : b1+a1+c1+c1,
      ' ' : b1+a1+c1+d1, '!' : b1+a1+d1+a1, '@' : b1+a1+d1+b1, '#' : b1+a1+d1+c1, '\$' : b1+a1+d1+d1,
      '%' : b1+b1+a1+a1, '^' : b1+b1+a1+b1, '&' : b1+b1+a1+c1, '*' : b1+b1+a1+d1, '(' : b1+b1+b1+a1,
      ')' : b1+b1+b1+b1, '+' : b1+b1+b1+c1, '=' : b1+b1+b1+d1, '"' : b1+b1+c1+a1, '№' : b1+b1+c1+b1,
      '~' : b1+b1+c1+c1, '?' : b1+b1+c1+d1, '\\' : b1+b1+d1+a1, '/' : b1+b1+d1+b1, '|' : b1+b1+d1+c1,
      '[' : b1+b1+d1+d1, ']' : b1+c1+a1+a1, '{' : b1+c1+a1+b1, '}' : b1+c1+a1+c1, '`' : b1+c1+a1+d1,
      '\'' : b1+c1+b1+a1, '<' : b1+c1+b1+b1, '>' : b1+c1+b1+c1,
    };

    for(var i = text.length / 4; i >= 1; i-- ){
      for(var i = 4; i >= 1; i-- ){
        m += text[x];
        x++;
      }
      var key = w.keys.firstWhere((k) => w[k] == m);
      res += key;
      m = '';
    }
    return(res);
  }
}