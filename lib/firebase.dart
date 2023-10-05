import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// void testDB() {
//   CollectionReference users = FirebaseFirestore.instance.collection('Users');
//   users.doc('crazydev').set({'Name': 'crazy', 'Email': '123@test.com'});
// }

CollectionReference booking = FirebaseFirestore.instance.collection('Booking');

Future<List> fetchDB() async {
  QuerySnapshot querySnapshot = await booking.get();

  // Get data from docs and convert map to List
  final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  return allData;
}

Future<void> insertDB(Appointment newAppointment) async {
  await booking.doc().set({
    'startTime': newAppointment.startTime,
    'endTime': newAppointment.endTime,
    'color': newAppointment.color.value,
    'startTimeZone': newAppointment.startTimeZone,
    'endTimeZone': newAppointment.endTimeZone,
    'notes': newAppointment.notes,
    'isAllDay': newAppointment.isAllDay,
    'subject': newAppointment.subject,
    'resourceIds': newAppointment.resourceIds,
    'id': newAppointment.id,
    'recurrenceRule': newAppointment.recurrenceRule
  });
}

Future<void> deleteDB(Appointment? oldAppointment) async {
  QuerySnapshot querySnapshot = await booking
      .where('startTime', isEqualTo: oldAppointment?.startTime)
      .get();

  querySnapshot.docs.forEach((doc) {
    doc.reference.delete();
  });
}

Future<void> updateDB(
    Appointment? oldAppointment, Appointment newAppointment) async {
  await deleteDB(oldAppointment);
  await insertDB(newAppointment);
}

Future<bool> isAddDB(Appointment newAppointment) async {
  QuerySnapshot querySnapshot = await booking
      .where('startTime', isLessThan: newAppointment.endTime)
      .get();

  List<QueryDocumentSnapshot> documents = querySnapshot.docs;

  List<QueryDocumentSnapshot> filteredDocuments = documents.where((doc) {
    var data = doc.data() as Map;
    var value = data["endTime"] as Timestamp;
    return value.toDate().isAfter(newAppointment.startTime);
  }).toList();

  if (filteredDocuments.isEmpty) {
    return true;
  } else {
    return false;
  }
}

Future<bool> isUpdateDb(
    Appointment? oldAppointment, Appointment newAppointment) async {
  QuerySnapshot querySnapshot = await booking
      .where('startTime', isNotEqualTo: oldAppointment?.startTime)
      .get();

  List<QueryDocumentSnapshot> documents = querySnapshot.docs;

  List<QueryDocumentSnapshot> filteredDocuments = documents.where((doc) {
    var data = doc.data() as Map;
    var value = data["endTime"] as Timestamp;
    var startime = data["startTime"] as Timestamp;
    return value.toDate().isAfter(newAppointment.startTime) &&
        startime.toDate().isBefore(newAppointment.endTime);
  }).toList();

  if (filteredDocuments.isEmpty) {
    return true;
  } else {
    return false;
  }
}
