part of 'hospital_bloc.dart';

abstract class HospitalState extends Equatable{}

class HospitalInitialState extends HospitalState {
  @override
  List<Object> get props => [];
}

class HospitalLoadingState extends HospitalState {
  @override
  List<Object> get props => [];
}

class HospitalLoadedState extends HospitalState {
  List<Hospital> hospitals;
  HospitalLoadedState({@required this.hospitals});

  @override
  List<Object> get props => [hospitals];
}

class HospitalFailedState extends HospitalState {
  String message;
  HospitalFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}
