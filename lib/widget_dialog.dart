import 'package:flutter/material.dart';
import 'style.dart';

class WidgetDialog extends StatefulWidget{
  final String title;
  

  const WidgetDialog({super.key, required this.title,});

  @override
  State<StatefulWidget> createState() => _WidgetDialogState();

}

class _WidgetDialogState extends State<WidgetDialog>{
    TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text("Add New Task", style: TextStyle(fontSize: 20),),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                autofocus:true,
                decoration: InputDecoration(
                  hintText: 'Task Name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(26, 0, 26, 0),child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text("Start: ${selectedStartTime.format(context)}", style: TextStyle(color: Colors.blueAccent, backgroundColor: Colors.white),),
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedStartTime,
                    );
                    if (pickedTime != null && pickedTime != selectedStartTime) {
                      setState(() {
                        selectedStartTime = pickedTime;
                      });
                    }
                  },
                ),
                Icon(Icons.forward),
                InkWell(
                  child: Text("End: ${selectedEndTime.format(context)}", style: TextStyle(color: Colors.blueAccent, backgroundColor: Colors.white),),
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedEndTime,
                    );
                    if (pickedTime != null && pickedTime != selectedEndTime) {
                      setState(() {
                        selectedEndTime = pickedTime;
                      });
                    }
                  },
                ),
              ],
            ),),
            
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [InkWell(child:Container(padding: EdgeInsets.fromLTRB(20, 10, 20, 10), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: secondaryColor), 
              
              child: Text('Cancel'),
              
            ),onTap: () {
                Navigator.of(context).pop();
              },), InkWell(child:Container(padding: EdgeInsets.fromLTRB(20, 10, 20, 10), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: successColor), 
              
              child: Text('Add'),
              
            ),onTap: () {
                Navigator.of(context).pop();
              },)],)
            , 
            
            
            SizedBox(height: 20),
          ],
        ),
      );
  }

}