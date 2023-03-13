import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoPageState();
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

    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    String getCurrentDate() {
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
      return '${date.day.toString()} ${months[date.month]} ${date.year.toString()}';
    }

    String nextDate() {
      setState(() {
        date = date.add(const Duration(days: 1));
      });
      return getCurrentDate();
    }

    String previousDate() {
      setState(() {
        date = date.subtract(const Duration(days: 1));
      });

      return getCurrentDate();
    }

    Widget dateBar() {
      return GestureDetector(
        onTap: () async {
          DateTime? selectedDate = await _selectDate(context);
          print(selectedDate);
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
                Text(getCurrentDate(), style: const TextStyle(fontSize: 20)),
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
          children: [dateBar()],
        ),
      ),
    );
  }
}
