import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:workshop2_bloc/res/strings/strings.dart';
import 'package:http/http.dart' as http;

part 'hospital_event.dart';
part 'hospital_state.dart';



class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  HospitalBloc() : super(HospitalInitial());

  @override
  Stream<HospitalState> mapEventToState(
    HospitalEvent event,
  ) async* {
    if (event is HospitalInitial) {
      yield HospitalInitial();
    } else if (event is LoadingHospital) {
      yield HospitalLoading();
      try {
        var hospitals = await getHospitals();
        yield HospitalLoaded(hospitals);
      } catch (e) {
        yield HospitalFailed(e.toString());
      }
    }
  }
}

Future<http.Response> getHospitals() {
  return http.get(Uri.https(AppStrings.url, "hospitals?&token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcmVhdGVfYnkiOiJHT1QgRE1EIiwiaWF0IjoxNjE2OTg0OTM5LCJleHAiOjE2MTY5OTU3Mzl9.gzAYUL2aaXndLiD2skS7rPfBkjTa-yu0kR0Kx09O1M0"));
}
