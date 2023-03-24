import 'package:flutter/material.dart';
import 'style.dart';

class TaskCheckBox extends StatefulWidget {
  final bool isDone;
  final taskName;
  final callback;
  final onLongPress;

  const TaskCheckBox({super.key, required this.isDone, required this.callback, required this.taskName, required, this.onLongPress});

  @override
  State<StatefulWidget> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: () {
          setState(() {
            _value = !_value;
          });
          widget.callback(widget, _value);
        },
        onLongPress: () {
          //TODO: Show popup here
          widget.onLongPress(widget.taskName);
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _value ? successColor : secondaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            _value ? Icons.done : Icons.circle,
            color: _value ? Colors.black : Colors.white,
          ),
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            _value = !_value;
          });
          widget.callback(widget, _value);
        },
        child: _value
            ? Text(
                widget.taskName,
                style: TextStyle(decoration: TextDecoration.lineThrough),
              )
            : Text(widget.taskName),
      )
    ]);
  }
}
