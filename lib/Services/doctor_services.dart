import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:luminous_key_task/Models/Api/doctor.dart';
import 'package:luminous_key_task/Models/Responses/httpresponse.dart';

import '../Api/api_client.dart';

class DoctorServices{
  Dio? _dio;

  DoctorServices() {
    _dio = ApiClient.getDio();
  }

  Future<HttpResponse<List<Doctor>>> getDoctors() async {
    try {
      final response = await _dio!.get("Doctors/GetDoctorsInfo");
      if (response.statusCode == 200) {
        List<Doctor> doctors =[];
        jsonDecode(response.data).forEach((v) {
          doctors.add(Doctor.fromJson(v));
        });
        return HttpResponse(
            isSuccess: true,
            data: doctors,
            message: "Get Successfully",
            responseCode: 200);
      } else {
        String error =
        response.toString();
        return HttpResponse(
            isSuccess: false,
            message: error,
            responseCode: 400);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.message.contains("SocketException")) {
          return HttpResponse(
              isSuccess: false,
              message: "Connection Failed",
              responseCode: 500);
        } else if (e.response != null) {
          String error =
          e.response!.toString();
          return HttpResponse(
              isSuccess: false,
              message: error,
              responseCode: 400);
        } else {
          return HttpResponse(
              isSuccess: false, message: (e.message), responseCode: 500);
        }
      } else {
        return HttpResponse(
            isSuccess: false, message: e.toString(), responseCode: 500);
      }
    }
  }
}