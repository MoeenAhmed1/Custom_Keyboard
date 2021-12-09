import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage()

        );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _readOnly=true;
  final textController=TextEditingController();
  List<String> suggestionsList=["12345","94836252","7627","9872","12354","92762","1837","9181","123","99","11","22","33","44","55","66","77","88"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("custom keyboard"),
      ),
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: 'Enter',
                          ),
                          readOnly: _readOnly,
                          showCursor: true,
                        ),
                        IconButton(
                          icon: Icon(Icons.keyboard),
                          onPressed: () {
                            setState(() {
                              _readOnly = !_readOnly;
                            });
                          },
                        ),



                      ],
                    ),
                  ),
                ),
              ),

              buildKeypad(_readOnly)

            ],

          ),
        ),

    );
  }
  Widget buildList()
  {
    String text=textController.text;
    List<String> suggestions=[];
    suggestions=suggestionsList.where((element) => element.contains(RegExp(text))).toList();
    if(suggestions.length>0) {
      return Container(
        height: 50,
        color: Colors.black38,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 115,
                child: ListTile(
                  title: Center(
                    child: Text(
                      suggestions[index], style: TextStyle(color: Colors.black),),
                  ),
                  onTap: () {
                    setState(() {
                      textController.text = suggestions[index];
                      textController.selection = TextSelection.fromPosition(
                          TextPosition(offset: textController.text.length));
                      suggestions = [];
                    });
                  },

                ),
              );
            }
        ),
      );
    }
    return Container();
  }
  Widget buildKeypad(bool read)
  {
    if(read) {
      return Container(
        color: Colors.black12,
        child: Column(
          children: [
            buildList(),

            Row(
              children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
              ],
            ),
            Row(
              children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
              ],
            ),
            Row(
              children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
              ],
            ),
            Row(
              children: [
                buildButton("<"),
                buildButton("0"),
                buildButton("<-"),
              ],
            ),
          ],
        ),
      );
    }
    return Container();
  }
  Widget buildButton(String val)
  {
    return Expanded(child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 2,color: Colors.black38),
      ),
      child: Text("$val",
      style:TextStyle(
          fontSize: 25.0,
        color: Colors.black54
      ),
      ),

      onPressed: (){
        if(val=="<-") {
          _handleBackspace();
        }
        else if(val!="<")
          {
            _insertText(val);
          }
      },
    )
    );
  }
  void _handleBackspace() {

    setState(() {
      if(textController.text.length>0)
        {
          textController.text=textController.text.substring(0,textController.text.length-1);
          textController.selection = TextSelection.fromPosition(TextPosition(offset: textController.text.length));
        }
    });
  }
  void _insertText(String myText) {
    setState(() {
      textController.text=textController.text+myText;
      textController.selection = TextSelection.fromPosition(TextPosition(offset: textController.text.length));
    });
  }
}



