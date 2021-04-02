import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workshop2_bloc/data/model/hospitals.dart';
import 'package:workshop2_bloc/data/model/my_location.dart';
import 'package:workshop2_bloc/data/repository/hospital_repository.dart';

import 'dart:math' as Math;

part 'hospital_event.dart';
part 'hospital_state.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  HospitalsRepository repository;
  MyLocation location;
  HospitalBloc({HospitalsRepositoryImpl repository, @required this.location})
      : super(null);

  @override
  Stream<HospitalState> mapEventToState(
    HospitalEvent event,
  ) async* {
    if (event is LoadHospitalEvent) {
      yield HospitalLoadingState();
      try {
        var hospitals = await repository.getHospitals();
        hospitals.forEach((element) {
          var idx = element.gps.indexOf(",");
          var latitude = double.parse(element.gps.substring(0, idx).trim());
          var longitude = double.parse(element.gps.substring(1, idx).trim());
          element.distance = calcDistance(
              location.latitude, location.longitude, latitude, longitude);
        });
        yield HospitalLoadedState(hospitals: hospitals);
      } catch (e) {
        yield HospitalFailedState(message: e.toString());
      }
    }
  }
}

double calcDistance(double lat1, double lon1, double lat2, double lon2) {
  double r = 6371000.0;
  double d2r = Math.pi / 180.0;

  double rLat1 = lat1 * d2r;
  double rLat2 = lat2 * d2r;

  double dLat = (lat2 - lat1) * d2r;
  double dLon = (lon2 - lon1) * d2r;

  double a = (Math.sin(dLat / 2) * Math.sin(dLat / 2)) +
      (Math.cos(rLat1) *
          Math.cos(rLat2) *
          (Math.sin(dLon / 2) * Math.sin(dLon / 2)));

  double d = 2 * r * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  return d;
}
