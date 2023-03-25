import 'package:flutter/material.dart';
import 'style.dart';
import 'profiles_box.dart';

class ScheduleTask extends StatefulWidget {
  final bool isDone;
  final taskName;
  final List<String> imageURLlist;
  final timeInterval;
  final callback;

  const ScheduleTask(
      {super.key,
      required this.isDone,
      required this.taskName,
      required this.imageURLlist,
      required this.timeInterval,
      required this.callback,
      });

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
          widget.callback(widget.taskName, widget.timeInterval[0], widget.timeInterval[1]);
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
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _value
                      ? Text(
                          widget.taskName,
                          style:
                              TextStyle(decoration: TextDecoration.lineThrough),
                        )
                      : Text(widget.taskName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Time: 10:00AM - 12:00PM'),
                  //  profileBox(widget.imageURLlist),
                ],
              )),
              Icon(
                _value ? Icons.done : Icons.circle,
                color: _value ? Colors.black : Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
