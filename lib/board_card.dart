import 'package:collabtask/profiles_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'style.dart';

class BoardCard extends StatefulWidget {
  final String boardName;
  final List<String> imageURLlist;
  List<String> emailURLlist;

  BoardCard(
      {super.key,
      required this.boardName,
      required this.imageURLlist,
      required this.emailURLlist});
  @override
  State<StatefulWidget> createState() => _BoardCardState();
}

class _BoardCardState extends State<BoardCard> {
  bool isEdit = false;
  // This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Discard Change?'),
        content: const Text('Proceed with discard change action'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              setState(() {
                isEdit = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            // height: isEdit ? 200 : 50,
            alignment: Alignment.topLeft,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Board Name'),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => setState(() {
                            isEdit = !isEdit;
                          }),
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.blue,
                            child: const Center(
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            isEdit = !isEdit;
                          }),
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.red,
                            child: const Center(
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                isEdit
                    ? Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            profileBox(widget.imageURLlist),
                            TextFormField(
                              initialValue: widget.boardName,
                              decoration: InputDecoration(
                                hintText: 'Board Name',
                                label: Text('Board Name'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(children: [
                              Text(
                                "Share With",
                                textAlign: TextAlign.left,
                              ),
                            ]),
                            ...List.generate(
                                widget.emailURLlist.length,
                                (index) => Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Flexible(
                                            child: Form(
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                child: TextFormField(
                                                  initialValue: widget
                                                      .emailURLlist[index],
                                                  validator: (value) =>
                                                      EmailValidator.validate(
                                                              value!)
                                                          ? null
                                                          : "Please enter a valid email",
                                                  decoration: InputDecoration(
                                                    hintText: 'Email',
                                                    label: Text('Email'),
                                                  ),
                                                ))),
                                                SizedBox(width: 10),
                                                
                                                InkWell(
                                                  onTap: () => setState(() {
                                                    widget.emailURLlist.removeAt(index);
                                                  }),
                                                  child: Icon(Icons.delete),)
                                        
                                      ],
                                    )),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => setState(() {
                                    widget.emailURLlist.add('');
                                  }),
                                  child: Text(
                                    '+ Add More',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: secondaryColor),
                                    child: Text('Discard'),
                                  ),
                                  onTap: () {
                                    _showAlertDialog(context);
                                  },
                                ),
                                InkWell(
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: successColor),
                                    child: Text('Save'),
                                  ),
                                  onTap: () {
                                    // TODO: Send data to server
                                    setState(() {
                                      isEdit = false;
                                    });
                                    
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ))
                    : Container(),
              ],
            ),
          )),
    );
  }
}
