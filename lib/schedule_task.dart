import 'package:flutter/material.dart';
import 'style.dart';

class ScheduleTask extends StatefulWidget {
  final bool isDone;
  final taskName;
  final List<String> imageURLlist;
  final timeInterval;

  const ScheduleTask({super.key, required this.isDone, required this.taskName, required this.imageURLlist, required this.timeInterval});

  @override
  State<StatefulWidget> createState() => _ScheduleTaskState();
}

class _ScheduleTaskState extends State<ScheduleTask> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.isDone;
  }

  Widget userImage(String imgURL){
    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.network(
                        imgURL,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          setState(() {
            _value = !_value;
          });
        },
        onLongPress: () {
          //TODO: Show popup here
          setState(() {
            _value = !_value;
          });
          widget.timeInterval[0].toString();
        },
        child: Container(
            decoration: BoxDecoration(
              color: _value ? successColor : secondaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            
                padding: EdgeInsets.all(26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Flexible(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        _value
                            ? Text(
                                widget.taskName,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              )
                            : Text(widget.taskName),Text('time: 10:00 - 12:00'),
                         Row(children: List.generate(widget.imageURLlist.length , (index) => userImage(widget.imageURLlist[index])),)
                      ],
                    ))
                    ,Icon(
                          _value ? Icons.done : Icons.circle,
                          color: _value ? Colors.black : Colors.white,
                        )
                  ],
                ),),
      ),
    );
  }
}
