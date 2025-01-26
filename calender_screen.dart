import 'package:flutter/material.dart';
import 'tracker_screen.dart';

class CalendarViewPage extends StatefulWidget {
  const CalendarViewPage({super.key});

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRACKER',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Calendar View',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Select your period start and end dates.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 31,
                  itemBuilder: (context, index) {
                    final date = DateTime(2025, 1, index + 1); // Example month/year
                    final isSelected = _isSelected(date);

                    return GestureDetector(
                      onTap: () => _onDateSelected(date),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.redAccent : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                          border: Border.all(
                            color: isSelected
                                ? Colors.redAccent
                                : Colors.grey[300]!,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (startDate != null || endDate != null)
              Column(
                children: [
                  if (startDate != null)
                    Text(
                      'Start Date: ${startDate!.toLocal()}'.split(' ')[0],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  if (endDate != null)
                    Text(
                      'End Date: ${endDate!.toLocal()}'.split(' ')[0],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                if (startDate != null && endDate != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrackingDetailsPage(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Log Your Period',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      if (startDate == null || (startDate != null && endDate != null)) {
        // Reset or set start date
        startDate = date;
        endDate = null;
      } else if (date.isAfter(startDate!)) {
        // Set end date if it comes after the start date
        endDate = date;
      } else {
        // Reset and set as start date if the selected date is before the current start date
        startDate = date;
        endDate = null;
      }
    });
  }

  bool _isSelected(DateTime date) {
    if (startDate == null) return false;
    if (startDate != null && endDate == null) {
      return date == startDate;
    }
    return startDate != null &&
        endDate != null &&
        date.isAfter(startDate!.subtract(const Duration(days: 1))) &&
        date.isBefore(endDate!.add(const Duration(days: 1)));
  }
}
