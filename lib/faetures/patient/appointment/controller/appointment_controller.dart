import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/widgets/custom_toast_show.dart';
import 'package:healthcare_hub/data/models/appointment_model.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
import 'package:healthcare_hub/data/shared_preference/shared_preference_services.dart';
import 'package:intl/intl.dart';

class AppointmentController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  FireStoreRepository fireStore = FireStoreRepository();
  ToastClass toast = ToastClass();
  var selectedDate = DateTime.now().obs;
  var selectedTimeSlot = "".obs;
  var notes = "".obs;

  List<String> timeSlots = [
    "10:00 AM",
    "11:00 AM",
    "12:30 PM",
    "2:00 PM",
    "3:30 PM",
    "5:00 PM",
  ];

  var isLoading = false.obs;

  Future<void> bookAppointment(String doctorID) async {
    isLoading.value = true;

    try {
      // Truncate selected date to remove time part
      final DateTime selected = selectedDate.value;
      final DateTime dateOnly = DateTime(
        selected.year,
        selected.month,
        selected.day,
      );

      // Check if the selected time slot is already booked for the same doctor
      final existing =
          await FirebaseFirestore.instance
              .collection("appointments")
              .where("doctorId", isEqualTo: doctorID)
              .where("date", isEqualTo: dateOnly)
              .where("timeSlot", isEqualTo: selectedTimeSlot.value)
              .get();

      if (existing.docs.isNotEmpty) {
        toast.showCustomToast(
          "This time slot is already booked for this doctor.",
        );
        return;
      }

      // Get user ID from preferences
      String? userID = await PreferenceHelper.getString("userID");

      if (userID == null) {
        toast.showCustomToast("User not logged in.");
        return;
      }

      // Create AppointmentModel
      AppointmentModel appointmentModel = AppointmentModel(
        patientId: userID,
        doctorId: doctorID,
        title: titleController.text,
        notes: notesController.text,
        date: dateOnly,
        timeSlot: selectedTimeSlot.value,
      );

      // Store appointment
      await fireStore.storeDataWithUUID(
        collectionName: "appointments",
        data: appointmentModel,
        toJson: (value) => value.toJson(),
      );

      toast.showCustomToast("Appointment booked successfully.");
      refreshAppointmentForm();
      Get.back();
    } catch (e) {
      toast.showCustomToast("Error booking appointment: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void refreshAppointmentForm() {
    titleController.clear();
    notesController.clear();
    selectedDate.value = DateTime.now();
    selectedTimeSlot.value = "";
    notes.value = "";
  }
}
