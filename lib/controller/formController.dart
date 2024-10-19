import 'package:biomark/model/UserInformantionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../view/Util/ToastMassage.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

void saveUserData(String dateOfBirth,String timeOfBirth,String locationOfBirth,
    String bloodGroup,String sex,String height,String ethnicity,String eyeColour, String userId,String state, BuildContext context2) async {


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
      'state': "Subscribe",
    };
  }

  try{

    if(state!="Unsubscribe"){

      await _firestore.collection("userInfo").add(infoMap()).then((value) {
        print("User Added");
        showToast('Saved Information.');
        Navigator.pop(context2);
      }).catchError((error) {
        print("Failed to add user: $error");
        showToast('Saved failed,Try again.');
      });
    }else{
      QuerySnapshot querySnapshot = await _firestore.collection('userInfo')
          .where("userId", isEqualTo: userId)
          .get();

      for (var doc in querySnapshot.docs) {
        await _firestore.collection('userInfo')
            .doc(doc.id)
            .update(infoMap());
      }
      showToast('Saved Information.');
      Navigator.pop(context2);
    }

  }catch(e){
    showToast("$e");
  }

}