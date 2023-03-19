import 'package:collabtask/task_check_box.dart';
import 'package:collabtask/widget_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'style.dart';
import "package:collabtask/schedule_task.dart";
import 'all_board_page.dart';
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoPageState();
}

class CircleIconButton extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color color;
  final Color iconColor;
  final VoidCallback onPressed;

  const CircleIconButton({
    super.key,
    required this.iconData,
    required this.size,
    required this.color,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: const CircleBorder(),
        ),
        child: Icon(
          iconData,
          color: iconColor,
          size: size * 0.6,
        ),
      ),
    );
  }
}

// Source: https://stackoverflow.com/questions/54019785/how-to-add-line-dash-in-flutter
class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class _TodoPageState extends State<TodoPage> {
  var date = DateTime.now();
  List<TaskCheckBox> taskList = [];

  @override
  void initState() {
    super.initState();
    taskList.add(TaskCheckBox(
      key: Key('0'),
      callback: _onChangedTask,
      isDone: false,
      taskName: ' My Task a ',
    ));
    taskList.add(TaskCheckBox(
      key: Key('1'),
      callback: _onChangedTask,
      isDone: false,
      taskName: ' My Task b ',
    ));
    taskList.add(TaskCheckBox(
      key: Key('2'),
      callback: _onChangedTask,
      isDone: false,
      taskName: ' My Task c ',
    ));
  }

  void _onChangedTask(TaskCheckBox changed, bool isDone) {
    setState(() {
      taskList.removeWhere((e) => e.key == changed.key);
      TaskCheckBox newStateTask = TaskCheckBox(
        key: changed.key,
        callback: _onChangedTask,
        isDone: isDone,
        taskName: changed.taskName,
      );
      if (isDone) {
        taskList.add(newStateTask);
      } else {
        taskList.insert(0, newStateTask);
      }
      taskList = [...taskList];
    });
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    DateTime? selectedDate = date;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    setState(() {
      date = selectedDate!;
    });
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    List getCurrentDate() {
      const months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return [
        date.day.toString(),
        ' ${months[date.month - 1]} ${date.year.toString()}'
      ];
    }

    List nextDate() {
      setState(() {
        date = date.add(const Duration(days: 1));
      });
      return getCurrentDate();
    }

    List previousDate() {
      setState(() {
        date = date.subtract(const Duration(days: 1));
      });

      return getCurrentDate();
    }

    Widget dateBar() {
      return GestureDetector(
        onTap: () async {
          await _selectDate(context);
        },
        child: Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    previousDate();
                  },
                ),
                RichText(
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(color: Colors.black, fontSize: 26),
                    children: <TextSpan>[
                      TextSpan(
                          text: getCurrentDate()[0],
                          style: const TextStyle(
                            color: Colors.red,
                          )),
                      TextSpan(
                        text: getCurrentDate()[1],
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    nextDate();
                  },
                ),
              ],
            )),
      );
    }

    Widget topMenu() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleIconButton(
              iconData: Icons.person,
              size: 60,
              color: Colors.white,
              iconColor: secondaryColor,
              onPressed: () {
                //  TODO: Add login page here
                print('User button pressed');
              }),
          Row(
            children: [
              Text('Board_Name '),
              CircleIconButton(
                  iconData: Icons.bookmark,
                  size: 60,
                  color: Colors.white,
                  iconColor: secondaryColor,
                  onPressed: () {
                    // TODO: Add board page here
                    print('Board button pressed');
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AllBoardPage()),
  );
                  })
            ],
          ),
        ],
      );
    }

   void addNewTask() async {
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WidgetDialog( title: 'Add Task',);
    },
  );
}

    Widget generalTaskList() {
      return (Container(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: taskList,
        ),
      ));
    }

    Widget taskBox() {
      return Expanded(
          child: Container(
        margin: const EdgeInsets.all(20),
        child: DottedBorder(
          color: Colors.white,
          strokeWidth: 4,
          borderType: BorderType.RRect,
          radius: Radius.circular(24),
          dashPattern: [16, 10],
          child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 66,
                      child: generalTaskList(),
                    ),
                  ),
                  MySeparator(
                    color: primaryColor,
                    height: 4,
                  ),
                  ScheduleTask(
                      isDone: false,
                      taskName: "taskName ",
                      imageURLlist: [demoUserImage1, demoUserImage1],
                      timeInterval: [DateTime.now(), DateTime.now()])
                ],
              )),
        ),
      ));
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [dateBar(), topMenu(), taskBox()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          addNewTask();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
