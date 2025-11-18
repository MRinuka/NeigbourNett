import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // You may need to run: flutter pub add intl

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  // --- Shows the date and time pickers ---
  Future<void> _pickDateTime() async {
    // 1. Pick the date
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (date == null) return; // User canceled

    // 2. Pick the time
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (time == null) return; // User canceled

    // 3. Combine date and time
    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      // Format the text for the text field
      _timeController.text =
          DateFormat('E, MMM d, yyyy • h:mm a').format(_selectedDateTime!);
    });
  }

  // --- Submits the form ---
  void _createEvent() {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      // TODO: Implement your event creation logic here
      // 1. Get all the data
      final eventName = _nameController.text;
      final location = _locationController.text;
      final description = _descriptionController.text;
      final startTime = _selectedDateTime; // This is the DateTime object

      // 2. Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Event "$eventName" created! (Demo)'),
          backgroundColor: Colors.green,
        ),
      );

      // 3. Go back to the previous page
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Create New Event'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // --- 1. Event Name ---
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an event name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // --- 2. Starting Time ---
            TextFormField(
              controller: _timeController,
              readOnly: true, // Makes the field not editable
              onTap: _pickDateTime, // Shows the picker on tap
              decoration: InputDecoration(
                labelText: 'Starting Time',
                hintText: 'Select a date and time',
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a starting time';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // --- 3. Location ---
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'E.g., "Community Pool Area"',
                prefixIcon: const Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // --- 4. Description ---
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Event Description',
                hintText: 'What is this event about?',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              minLines: 4,
              maxLines: 6,
            ),
            const SizedBox(height: 30),

            // --- 5. Create Event Button ---
            ElevatedButton(
              onPressed: _createEvent,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'Create Event',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}