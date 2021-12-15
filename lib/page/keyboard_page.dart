import 'package:custom_keyboard/cubit/data_cubit.dart';
import 'package:custom_keyboard/model/data_model.dart';
import 'package:custom_keyboard/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard({Key? key}) : super(key: key);

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  bool _readOnly=true;
  bool _textFieldTap=false;
  final textController=TextEditingController();


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
             Row(
              children: <Widget>[
                 Flexible(
                  child: buildTextField(),
                ),
                buildToggleButton(),
              ],
            ),
            (_readOnly && _textFieldTap)?buildKeypad():Container(),
          ],

        ),
      ),

    );
  }
  Widget buildToggleButton()
  {
    return IconButton(
      icon: Icon(Icons.keyboard),
      onPressed: () {
        setState(() {
          _readOnly = !_readOnly;
        });
      },
    );
  }

Widget buildTextField()
{
  return TextField(
    onTap: (){
      setState(() {
        _textFieldTap=true;
      });
    },
    controller: textController,
    decoration: const InputDecoration(
      hintText: 'Enter',

    ),
    readOnly: _readOnly,
    showCursor: true,
  );
}
  Widget buildKeypad()
  {

    {
      return Container(
        color: Colors.black12,
        child: Column(
          children: [
            buildList(),
            Row(
              children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
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
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
              ],
            ),
            Row(
              children: [
                buildButton("<"),
                buildButton("0"),
                buildButton("<-"),
              ],
            )
          ],
        ),
      );
    }

  }
  Widget buildList()
  {
    String text=textController.text;
    List<Data> suggestions=[];

        {
      return BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          context.read<DataCubit>().getDataList();

          if(state is DataLoaded) {

            suggestions=state.datalist.toList().where((element) => element.string.contains(RegExp(text))).toList();


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
                            suggestions[index].string, style: TextStyle(color: Colors.black),),
                        ),
                        onTap: () {
                          setState(() {
                            textController.text = suggestions[index].string;
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
          if(state is DataLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      );
    }


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
        else{
          setState(() {
            _readOnly = !_readOnly;
          });
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
