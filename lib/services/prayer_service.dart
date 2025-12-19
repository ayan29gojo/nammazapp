import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/namaz_model.dart';

class PrayerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('Not signed in');
    }
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _prayersRef {
    return _firestore.collection('users').doc(_uid).collection('prayers');
  }

  Stream<List<NamazModel>> streamPrayers() {
    return _prayersRef
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((d) => NamazModel.fromMap(d.data(), id: d.id))
          .toList();
    });
  }

  Future<void> addPrayer(NamazModel prayer) async {
    await _prayersRef.add({
      ...prayer.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deletePrayer(String id) async {
    await _prayersRef.doc(id).delete();
  }
}
