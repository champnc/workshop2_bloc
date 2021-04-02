import 'package:workshop2_bloc/res/strings/strings.dart';
import 'package:workshop2_bloc/data/model/hospitals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class HospitalsRepository {
  Future<List<Hospital>> getHospitals();
}

class HospitalsRepositoryImpl implements HospitalsRepository {
  @override
  Future<List<Hospital>> getHospitals() async {
    var response = await http.get(AppStrings.url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Hospital> hospitals = Hospitals.fromJson(data).hospitals;
      return hospitals;
    } else {
      throw Exception();
    }
  }
}