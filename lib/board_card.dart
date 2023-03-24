import 'package:collabtask/profiles_box.dart';
import 'package:flutter/material.dart';

import 'style.dart';

class BoardCard extends StatefulWidget {
  final String boardName;
  final List<String> imageURLlist;
  final List<String> emailURLlist;

  const BoardCard(
      {super.key, required this.boardName, required this.imageURLlist, required this.emailURLlist});
  @override
  State<StatefulWidget> createState() => _BoardCardState();
}

class _BoardCardState extends State<BoardCard> {
  bool isEdit = true;
  TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.boardName;
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
            child:
                Column(
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
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
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
                        child:
                        Column(
                          children: [
                            profileBox(widget.imageURLlist),
                            TextField(
                              controller:  _controller,
                              decoration: InputDecoration(
                                hintText: 'Board Name',
                                label: Text('Board Name'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(children:[Text("Share With" ,textAlign: TextAlign.left,),]),
                            userImage('https://picsum.photos/250?image=9', 60),
                            
                            
                          ],
                         
                      ))
                    : Container(),
                    

                  ],
                  
                ),
                
              
            
          )),
    );
  }
}
