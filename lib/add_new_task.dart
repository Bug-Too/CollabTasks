import 'package:flutter/material.dart';
import 'style.dart';
import 'profiles_box.dart';

class AddNewTask extends StatefulWidget {
  final DateTime currentDate;
  AddNewTask({
    super.key,
    required this.currentDate,
  });

  @override
  State<StatefulWidget> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  bool isAddTime = false;
  @override
  Widget build(BuildContext context) {
    DateTime selectedStartDateTime = widget.currentDate;
    DateTime selectedEndDateTime = widget.currentDate;
    return Dialog(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Text(
            "Add New Task",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          // Container(
          //   margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          //   child: profileBox(widget.imageURLlist),
          // ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              autofocus: true,
              // initialValue: widget.taskName,
              decoration: InputDecoration(
                hintText: 'Task Name',
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          !isAddTime
              ? Container(
                  padding: EdgeInsets.fromLTRB(26, 0, 0, 0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () => setState(() {
                                isAddTime = true;
                              }),
                          child: Text(
                            "+ Add Time",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                backgroundColor: Colors.white),
                          ))
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.fromLTRB(26, 0, 26, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Text(
                          "Start: ${selectedStartTime.format(context)}",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              backgroundColor: Colors.white),
                        ),
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedStartTime,
                          );
                          if (pickedTime != null &&
                              pickedTime != selectedStartTime) {
                            setState(() {
                              selectedStartTime = pickedTime;
                              selectedStartDateTime = DateTime(
                                  selectedStartDateTime.year,
                                  selectedStartDateTime.month,
                                  selectedStartDateTime.day,
                                  pickedTime.hour,
                                  pickedTime.minute);
                            });
                          }
                        },
                      ),
                      Icon(Icons.forward),
                      InkWell(
                        child: Text(
                          "End: ${selectedEndTime.format(context)}",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              backgroundColor: Colors.white),
                        ),
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedEndTime,
                          );
                          if (pickedTime != null &&
                              pickedTime != selectedEndTime) {
                            setState(() {
                              selectedEndTime = pickedTime;
                              selectedEndDateTime = DateTime(
                                  selectedEndDateTime.year,
                                  selectedEndDateTime.month,
                                  selectedEndDateTime.day,
                                  pickedTime.hour,
                                  pickedTime.minute);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: secondaryColor),
                  child: Text('Cancel'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: successColor),
                  child: Text('Add'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
