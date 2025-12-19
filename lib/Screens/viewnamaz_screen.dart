import 'package:flutter/material.dart';
import 'package:untitled75/Screens/addnamaz_screen.dart';
import '../models/namaz_model.dart';
import '../services/prayer_service.dart';

class ViewNamazScreen extends StatelessWidget {
  ViewNamazScreen({super.key});

  final PrayerService _prayerService = PrayerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Namaz Records')),
      body: StreamBuilder<List<NamazModel>>(
        stream: _prayerService.streamPrayers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final records = snapshot.data!;
          if (records.isEmpty) {
            return const Center(child: Text('No records found 😔'));
          }

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final item = records[index];
              return Card(
                child: ListTile(
                  title: Text('${item.name} - ${item.status}'),
                  subtitle: Text(item.date),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      try {
                        final id = item.id;
                        if (id == null) return;
                        await _prayerService.deletePrayer(id);
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to delete: $e')),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNamazScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
