import 'package:biomark/model/UserInformantionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../view/Util/ToastMassage.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

void saveUserData(String dateOfBirth,String timeOfBirth,String locationOfBirth,
    String bloodGroup,String sex,String height,String ethnicity,String eyeColour, String userId) async {


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
      'userId':userId,
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
    showToast('Saved Information.');
  }).catchError((error) {
    print("Failed to add user: $error");
    showToast('Saved failed,Try again.');
  });
}