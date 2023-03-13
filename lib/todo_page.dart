import 'package:flutter/material.dart';

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

  CircleIconButton({
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
          shape: CircleBorder(),
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

class _TodoPageState extends State<TodoPage> {
  var date = DateTime.now();

  Future<DateTime?> _selectDate(BuildContext context) async {
    DateTime? selectedDate = date;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(2015, 8),
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
        ' ${months[date.month]} ${date.year.toString()}'
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
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                    style: const TextStyle(color: Colors.black, fontSize: 24),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Page'),
      ),
      body: Center(
        child: Column(
          children: [
            dateBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleIconButton(
                    iconData: Icons.person,
                    size: 50,
                    color: Colors.white,
                    iconColor: Color.fromARGB(255, 255, 175, 204),
                    onPressed: () {
                      //  TODO: Add login page here
                      print('Button pressed');
                    }),
                Row(
                  children:[
                    Text('Board_Name '),
                    CircleIconButton(
                        iconData: Icons.bookmark,
                        size: 50,
                        color: Colors.white,
                        iconColor: Color.fromARGB(255, 255, 175, 204),
                        onPressed: () {
                          // TODO: Add board page here
                          print('Button pressed');
                        })
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
