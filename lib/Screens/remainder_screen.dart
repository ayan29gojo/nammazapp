import 'package:flutter/material.dart';


class NamazReminderPage extends StatefulWidget {
  const NamazReminderPage({super.key});

  @override
  State<NamazReminderPage> createState() => _NamazReminderPageState();
}

class _NamazReminderPageState extends State<NamazReminderPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _namazController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  int? _editingIndex;
  List<Map<String, String>> reminders = [];

  void _saveReminder() {
    final date = _dateController.text.trim();
    final namaz = _namazController.text.trim();
    final note = _noteController.text.trim();

    if (date.isEmpty || namaz.isEmpty || note.isEmpty) return;

    setState(() {
      if (_editingIndex == null) {
        reminders.add({
          'date': date,
          'namaz': namaz,
          'note': note,
        });
      } else {
        reminders[_editingIndex!] = {
          'date': date,
          'namaz': namaz,
          'note': note,
        };
        _editingIndex = null;
      }

      _dateController.clear();
      _namazController.clear();
      _noteController.clear();
    });
  }

  void _editReminder(int index) {
    setState(() {
      _editingIndex = index;
      _dateController.text = reminders[index]['date']!;
      _namazController.text = reminders[index]['namaz']!;
      _noteController.text = reminders[index]['note']!;
    });
  }

  void _clearForm() {
    setState(() {
      _editingIndex = null;
      _dateController.clear();
      _namazController.clear();
      _noteController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Row(
          children: [
            Icon(Icons.mosque, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Namaz Reminder',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Enter Date (DD/MM/YYYY)',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _namazController,
              decoration: const InputDecoration(
                labelText: 'Enter Namaz (e.g. Fajr, Zuhar, Asr, Maghrib, Isha)',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Add Note (e.g. Read Surah Yaseen after Fajr)',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveReminder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_editingIndex == null ? 'Save' : 'Update'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clearForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminders[index];
                  return Card(
                    color: Colors.green[50],
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.access_time, color: Colors.green),
                      title: Text(
                        reminder['namaz'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${reminder['note']}\nDate: ${reminder['date']}',
                      ),
                      isThreeLine: true,
                      onTap: () => _editReminder(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}