import 'dart:core';

import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

enum selectedOption { YES, NO }

class _AddQuestionState extends State<AddQuestion> {
  final List<TextEditingController> _question = [];
  final List<TextEditingController> _Yes = [];
  final List<TextEditingController> _No = [];

  double textfieldBottomPadding = 15,
      textFieldRounded = 10,
      inputFieldPadding = 2;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addField();
    });
  }

  _addField() {
    setState(() {
      _question.add(TextEditingController());
      _Yes.add(TextEditingController());
      _No.add(TextEditingController());
    });
  }

  _removeItem(i) {
    setState(() {
      _question.removeAt(i);
      _Yes.removeAt(i);
      _No.removeAt(i);
    });
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    // FormData formData = FormData.fromMap({});
    //
    // for (int i = 0; i < _question.length; i++) {
    //   formData.fields.add(MapEntry("questions[]", _question[i].text));
    //   formData.fields.add(MapEntry("Yes[]", _Yes[i].text));
    //   formData.fields.add(MapEntry("No[]", _No[i].text));
    // }
    // networkRequest(
    //   context : context,
    //   requestType :'post',
    //   url :,
    //   data : formData,
    //   action : (r){
    //     Navigator.pop(context,true);
    //   }
    // );
  }

  selectedOption _character;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Edit'),
        backgroundColor: Color.fromRGBO(34, 187, 51, 1.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _addField();
                  },
                  child: const Icon(Icons.add_circle),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  for (int i = 0; i < _question.length; i++)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: const Icon(Icons.remove_circle),
                              onTap: () {
                                _removeItem(i);
                              },
                            )
                          ],
                        ),
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(inputFieldPadding),
                                  child: TextFormField(
                                    controller: _question[i],
                                    validator: (value) {
                                      if (value == "") {
                                        return "Please Enter the question";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 5),
                                      ),
                                      label: const Text('Enter your question'),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.all(inputFieldPadding),
                                child: ListTile(
                                  title: const Text('YES'),
                                  leading: Radio<selectedOption>(
                                    value: selectedOption.YES,
                                    groupValue: _character,
                                    onChanged: (selectedOption value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(inputFieldPadding),
                                child: ListTile(
                                  title: const Text('NO'),
                                  leading: Radio<selectedOption>(
                                    value: selectedOption.NO,
                                    groupValue: _character,
                                    onChanged: (selectedOption value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    label: Text('Other Opinion'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 0.005,
                        )
                      ],
                    )
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                _submit();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.blueAccent,
              child: Padding(
                padding: EdgeInsets.all(inputFieldPadding),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Save',
                      style: TextStyle(color: Color.fromRGBO(34, 187, 51, 1.0), fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
