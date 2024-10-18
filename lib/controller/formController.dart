import 'package:biomark/model/UserInformantionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

void saveUserData(String dateOfBirth,String timeOfBirth,String locationOfBirth,String bloodGroup,String sex,String height,String ethnicity,String eyeColour){
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


  CollectionReference usersInformation = FirebaseFirestore.instance.collection('usersInformation');

  usersInformation.add(useInfer).then((value){
      if (kDebugMode) {
        print("User data added");
      }
    }).catchError((onError){
    if (kDebugMode) {
      print("Failed to add user: $onError");
    }
  });
}