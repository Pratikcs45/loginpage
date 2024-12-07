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
      appBar: AppBar(
        title: Text('You'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Replace with user's profile image URL
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello,',
                        style: TextStyle(fontSize: 20, color: Colors.grey)),
                    Text(
                      widget.username,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildActionButton('Your OPD', Colors.blue),
                _buildActionButton('Your Performance', Colors.orange),
                _buildActionButton('Your Outcomes', Colors.green),
                _buildActionButton('Medical Retailers', Colors.yellow),
                _buildActionButton('Your Doctor', Colors.red),
                _buildActionButton('Your Training', Colors.blue.shade200),
              ],
            ),
            const SizedBox(height: 16),
            CalendarSlider(
              controller: _calendarController,
              selectedDayPosition: SelectedDayPosition.center,
              fullCalendarScroll: FullCalendarScroll.vertical,
              backgroundColor: Colors.lightBlue,
              fullCalendarWeekDay: WeekDay.short,
              selectedTileBackgroundColor: Colors.white,
              monthYearButtonBackgroundColor: Colors.white,
              monthYearTextColor: Colors.black,
              tileBackgroundColor: Colors.lightBlue,
              selectedDateColor: Colors.black,
              dateColor: Colors.white,
              tileShadow: BoxShadow(
                color: Colors.black.withOpacity(1),
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
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text('Test dr'),
                subtitle: Text('opd time: 12:00 PM to 2:00 PM'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ongoing', style: TextStyle(color: Colors.green)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Opd started'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('End Opd'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, Color color) {
    return Container(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}
