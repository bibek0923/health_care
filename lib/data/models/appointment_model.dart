import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String patientId;
  final String doctorId;
  final String title;
  final DateTime date;
  final String timeSlot;
  final String? notes;

  AppointmentModel({
    required this.patientId,
    required this.doctorId,
    required this.title,
    required this.date,
    required this.timeSlot,
    this.notes,
  });

  /// Convert the model to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'timeSlot': timeSlot,
      'title': title,
      'date': date,
      'notes': notes,
    };
  }

  /// Explicit JSON serialization method
  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'timeSlot': timeSlot,
      'title': title,
      'date': date,
      'notes': notes,
    };
  }

  /// Create model from Firestore map
  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      patientId: map['patientId'] ?? '',
      doctorId: map['doctorId'] ?? '',
      timeSlot: map['timeSlot'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? DateTime.now(),
      notes: map['notes'] ?? '',
    );
  }
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientId: json['patientId'] ?? '',
      doctorId: json['doctorId'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] is Timestamp
          ? (json['date'] as Timestamp).toDate()
          : DateTime.tryParse(json['date'].toString()) ?? DateTime.now(),
      notes: json['notes'],
    );
  }

}
