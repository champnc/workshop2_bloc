part of 'hospital_bloc.dart';

@immutable
abstract class HospitalState {}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  HospitalLoaded(http.Response hospitals);
}

class HospitalFailed extends HospitalState {
  HospitalFailed(String string);
}
