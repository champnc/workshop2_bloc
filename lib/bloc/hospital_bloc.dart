import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workshop2_bloc/data/model/hospitals.dart';
import 'package:workshop2_bloc/data/repository/hospital_repository.dart';

part 'hospital_event.dart';
part 'hospital_state.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  HospitalsRepository repository;
  HospitalBloc({@required this.repository}) : super(null);

  @override
  Stream<HospitalState> mapEventToState(
    HospitalEvent event,
  ) async* {
    if (event is LoadHospitalEvent) {
      yield HospitalLoadingState();
      try {
        var hospitals = await repository.getHospitals();
        yield HospitalLoadedState(hospitals: hospitals);
      } catch (e) {
        yield HospitalFailedState(message: e.toString());
      }
    }
  }
}
