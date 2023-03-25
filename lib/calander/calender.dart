import 'package:ami_milk/Home%20Page/horizontal_menu/horiItems.dart';
import 'package:ami_milk/fetch_from_firebase/provaider/cartProvaider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

CartProvider? cartProvider;

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _firstDay = DateTime(2022);
  DateTime _lastDay = DateTime.now().add(const Duration(days: 365));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.fatchCartData();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: ListView(children: [
        Container(
          child: Column(
            children: [
              TableCalendar(
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                rowHeight: 60,
                daysOfWeekHeight: 60,
                headerStyle: HeaderStyle(
                  titleTextStyle: const TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold),
                  formatButtonTextStyle: const TextStyle(color: Colors.green),
                  formatButtonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal, width: 2),
                  ),
                  leftChevronIcon: const Icon(
                    Icons.arrow_back,
                    color: Colors.teal,
                    size: 28,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.teal,
                    size: 28,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.red),
                ),
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(color: Colors.red),
                  todayDecoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  if (_isSelectableDay(selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    HoriItems();
                  }
                },
                selectedDayPredicate: (day) {
                  return _selectedDay != null && isSameDay(_selectedDay!, day);
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
              ),
              Column(
                children: cartProvider!.getCartDataList.map((e) {
                  // int index = cartProvider!.getItemsDataList.indexOf(e);

                  // sum = sum + ((e.itemQuantity)! * (e.itemPrice)!);
                  return HoriItems(
                    itemId: e.itemId,
                    itemName: e.itemName,
                    imageLink: e.imageLink,
                    itemQuantity: e.itemQuantity,
                    itemPrice: e.itemPrice,
                    itemCount: e.itemCount,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  bool _isSelectableDay(DateTime day) {
    return day.isAfter(_firstDay.subtract(Duration(days: 1))) &&
        day.isBefore(_lastDay.add(Duration(days: 1)));
  }
}
