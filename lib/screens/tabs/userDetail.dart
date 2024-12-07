import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;
  final String username;
  final String email;

  UserDetailScreen({
    required this.userId,
    required this.username,
    required this.email,
  });

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final CalendarSliderController _calendarController =
      CalendarSliderController();
  late DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      Text(
                        widget.username,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.email,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  _buildActionButton('Your OPD', Colors.teal),
                  _buildActionButton('Your Performance', Colors.teal),
                  _buildActionButton('Your Outcomes', Colors.teal),
                  // _buildActionButton('Medical Retailers', Colors.teal),
                  // _buildActionButton('Your Doctor', Colors.teal),
                  // _buildActionButton('Your Training', Colors.teal),
                ],
              ),
              const SizedBox(height: 6),
              CalendarSlider(
                controller: _calendarController,
                selectedDayPosition: SelectedDayPosition.center,
                fullCalendarScroll: FullCalendarScroll.vertical,
                fullCalendarWeekDay: WeekDay.short,
                selectedTileBackgroundColor: Colors.white,
                monthYearButtonBackgroundColor: Colors.white,
                monthYearTextColor: Colors.black,
                tileBackgroundColor: Colors.teal,
                selectedDateColor: Colors.black,
                dateColor: Colors.white,
                tileShadow: BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                ),
                locale: 'en',
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 100)),
                lastDate: DateTime.now().add(const Duration(days: 100)),
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _calendarController.goToDay(DateTime.now());
                },
                child: const Text("Go to today"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Selected date is $_selectedDate',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, Color color) {
    return Container(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(70),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
