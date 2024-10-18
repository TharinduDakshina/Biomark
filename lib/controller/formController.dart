import 'package:biomark/model/UserInformantionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<bool> saveUserData(String dateOfBirth,String timeOfBirth,String locationOfBirth,
    String bloodGroup,String sex,String height,String ethnicity,String eyeColour) async {


  UserInformationModel useInfer=UserInformationModel(
    dateOfBirth: dateOfBirth,
    timeOfBirth: timeOfBirth,
    locationOfBirth: locationOfBirth,
    bloodGroup: bloodGroup,
    sex: sex,
    height: height,
    ethnicity: ethnicity,
    eyeColour: eyeColour,
  );

  Map<String, String?> infoMap() {
    return {
      'dateOfBirth': useInfer.dateOfBirth,
      'timeOfBirth': useInfer.timeOfBirth,
      'locationOfBirth': useInfer.locationOfBirth,
      'bloodGroup': useInfer.bloodGroup,
      'sex': useInfer.sex,
      'height': useInfer.height,
      'ethnicity': useInfer.ethnicity,
      'eyeColour': useInfer.eyeColour,
    };
  }



  await _firestore.collection("userInfo").add(infoMap()).then((value) {
    print("User Added");
  return true;
  }).catchError((error) {
    print("Failed to add user: $error");
    return false;
  });
return false;
}