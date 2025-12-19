import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/namaz_model.dart';
import '../services/prayer_service.dart';

class AddNamazScreen extends StatefulWidget {
  const AddNamazScreen({super.key});

  @override
  State<AddNamazScreen> createState() => _AddNamazScreenState();
}

class _AddNamazScreenState extends State<AddNamazScreen> {
  final PrayerService _prayerService = PrayerService();

  String selectedPrayer = 'Fajr';
  String selectedStatus = 'Prayed';

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Namaz')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedPrayer,
              items: const ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => selectedPrayer = val!),
            ),
            DropdownButton<String>(
              value: selectedStatus,
              items: const ['Prayed', 'Missed']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => selectedStatus = val!),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving
                    ? null
                    : () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final navigator = Navigator.of(context);

                        setState(() => _saving = true);
                        try {
                          final namaz = NamazModel(
                            name: selectedPrayer,
                            status: selectedStatus,
                            date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          );

                          await _prayerService.addPrayer(namaz);

                          messenger.showSnackBar(
                            const SnackBar(content: Text('Namaz saved successfully!')),
                          );
                          navigator.pop(true);
                        } catch (e) {
                          messenger.showSnackBar(
                            SnackBar(content: Text('Failed to save: $e')),
                          );
                        } finally {
                          if (mounted) setState(() => _saving = false);
                        }
                      },
                child: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Namaz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
