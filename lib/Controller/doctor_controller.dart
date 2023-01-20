import 'package:flutter/material.dart';
import 'package:luminous_key_task/Models/Api/doctor.dart';
import '../Models/Api/user.dart';
import '../Models/Responses/httpresponse.dart';
import '../Services/auth_services.dart';
import '../Services/doctor_services.dart';
import '../Utils/user_utils.dart';

class DoctorController with ChangeNotifier {
  List<Doctor>? doctors;
  bool waiting = true;

  Future getDoctors() async {
    DoctorServices doctorServices = DoctorServices();

    HttpResponse response =
    await doctorServices.getDoctors();
    if(response.isSuccess==true){
      setDoctors(response.data);
    }
  }


  void setDoctors(List<Doctor>? doctors) {
    this.doctors = doctors;
    waiting = false;
    notifyListeners();
  }
}
