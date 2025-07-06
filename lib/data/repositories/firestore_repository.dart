import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:uuid/uuid.dart';
import '../../core/widgets/custom_toast_show.dart';
import '../shared_preference/shared_preference_services.dart';

class FireStoreRepository {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final ToastClass toast = ToastClass();
  static const Uuid uuid = Uuid();

  /// Store Data with Random UUID
  Future<String> storeDataWithUUID<T>({
    required String collectionName,
    required T data,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    try {
      String documentId = uuid.v4();
      await fireStore.collection(collectionName).doc(documentId).set(toJson(data));
      // toast.showCustomToast("Data stored successfully!");
      return documentId;
    } catch (e) {
      // toast.showCustomToast("Failed to store data: $e");
      throw Exception("Failed to store data: $e");
    }
  }

  /// Store Data with User ID (User-Specific)
  Future<void> storeDataWithUserID<T>({
    required String collectionName,
    required T data,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    try {
      String? userId = await PreferenceHelper.getString("userID");
      if (userId == null) throw Exception("User not authenticated!");
      await fireStore.collection(collectionName).doc(userId).set(toJson(data));
      // toast.showCustomToast("User data stored successfully!");
    } catch (e) {
      toast.showCustomToast("Failed to store user data: $e");
      throw Exception("Failed to store user data: $e");
    }
  }

  /// Get Data Using a Document ID as a Stream
  Stream<T?> getDataById<T>({
    required String collectionName,
    required String documentId,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    return fireStore.collection(collectionName).doc(documentId).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  /// Get Data Using User ID as a Stream
  Stream<T?> getDataByUserID<T>({required String collectionName, required T Function(Map<String, dynamic>) fromJson,}) async* {
    String? userId = await PreferenceHelper.getString("userID");
    if (userId == null) throw Exception("User not authenticated!");
    yield* fireStore.collection(collectionName).doc(userId).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  /// Get All Documents in a Collection as a Stream
  Stream<List<T>> getAllData<T>({
    required String collectionName,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    return fireStore.collection(collectionName).snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => fromJson(doc.data()))
          .toList();
    });
  }

  /// Update Data by Document ID
  Future<void> updateDataById({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      await fireStore.collection(collectionName).doc(documentId).update(updates);
      toast.showCustomToast("Data updated successfully!");
    } catch (e) {
      toast.showCustomToast("Failed to update data: $e");
      throw Exception("Failed to update data: $e");
    }
  }

  /// Update Data Using User ID
  Future<void> updateDataByUserID({
    required String collectionName,
    required Map<String, dynamic> updates,
  }) async {
    try {
      String? userId = await PreferenceHelper.getString("userID");
      if (userId == null) throw Exception("User not authenticated!");
      await fireStore.collection(collectionName).doc(userId).update(updates);
      toast.showCustomToast("User data updated successfully!");
    } catch (e) {
      toast.showCustomToast("Failed to update user data: $e");
      throw Exception("Failed to update user data: $e");
    }
  }

  /// Delete Data by Document ID
  Future<void> deleteDataById({
    required String collectionName,
    required String documentId,
  }) async {
    try {
      await fireStore.collection(collectionName).doc(documentId).delete();
      toast.showCustomToast("Data deleted successfully!");
    } catch (e) {
      toast.showCustomToast("Failed to delete data: $e");
      throw Exception("Failed to delete data: $e");
    }
  }

  /// Delete Data Using User ID
  Future<void> deleteDataByUserID({
    required String collectionName,
  }) async {
    try {
      String? userId = await PreferenceHelper.getString("userID");
      if (userId == null) throw Exception("User not authenticated!");
      await fireStore.collection(collectionName).doc(userId).delete();
      toast.showCustomToast("User data deleted successfully!");
    } catch (e) {
      toast.showCustomToast("Failed to delete user data: $e");
      throw Exception("Failed to delete user data: $e");
    }
  }

  /// Send Friend Request
  Future<String?> sendFriendRequest(String currentUserId, String targetUserId) async {
    try {
      /// Update target user's receivedRequests
      await fireStore.collection("tellMe_users").doc(targetUserId).update({
        "receivedRequests": FieldValue.arrayUnion([currentUserId]),
      });
      /// Update current user's sendRequests
      await fireStore.collection("tellMe_users").doc(currentUserId).update({
        "sendRequests": FieldValue.arrayUnion([targetUserId]),
      });
      toast.showCustomToast("Request sent successfully");
      return "success";
    } catch (e) {
      log("Error sending friend request: ${e.toString()}");
      return null;
    }
  }

  Future<String?> acceptFriendRequest(String currentUserId, String senderUserId) async {
    final batch = fireStore.batch();
    try {
      final currentUserRef = fireStore.collection("tellMe_users").doc(currentUserId);
      final senderUserRef = fireStore.collection("tellMe_users").doc(senderUserId);
      /// Update current user
      batch.update(currentUserRef, {
        "receivedRequests": FieldValue.arrayRemove([senderUserId]),
        "friends": FieldValue.arrayUnion([senderUserId]),
      });
      /// Update sender user
      batch.update(senderUserRef, {
        "sendRequests": FieldValue.arrayRemove([currentUserId]),
        "friends": FieldValue.arrayUnion([currentUserId]),
      });
      await batch.commit();
      toast.showCustomToast("Request accepted successfully");
      return "success";
    } catch (e) {
      log(" Error accepting friend request: ${e.toString()}");
      return null;
    }
  }

  Future<String?> declineFriendRequest(String currentUserId, String senderUserId) async {
    final batch = fireStore.batch();
    try {
      final currentUserRef = fireStore.collection("tellMe_users").doc(currentUserId);
      final senderUserRef = fireStore.collection("tellMe_users").doc(senderUserId);
      /// Update current user
      batch.update(currentUserRef, {
        "receivedRequests": FieldValue.arrayRemove([senderUserId]),
      });
      /// Update sender user
      batch.update(senderUserRef, {
        "sendRequests": FieldValue.arrayRemove([currentUserId]),
      });

      await batch.commit();
      toast.showCustomToast("Request declined successfully");
      return "success";
    } catch (e) {
      log(" Error declining friend request: ${e.toString()}");
      return null;
    }
  }
Future<PatientModel?> getPatientById(String patientId) async {
    try {
      DocumentSnapshot doc = await fireStore.collection('healthCare_hub').doc(patientId).get();
      if (doc.exists) {
        return PatientModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching patient: $e");
    }
    return null;
  }

}

