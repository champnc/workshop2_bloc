import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop2_bloc/bloc/hospital_bloc.dart';
import 'package:workshop2_bloc/data/model/hospitals.dart';
import 'package:workshop2_bloc/data/repository/hospital_repository.dart';
import 'dart:math' as Math;
import 'MyObserver.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalBloc(repository: HospitalsRepositoryImpl()),
      child: MaterialApp(
        title: 'Workshop 2 with BLOC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HospitalBloc hospitalBloc;

  @override
  void initState() {
    super.initState();
    hospitalBloc = BlocProvider.of<HospitalBloc>(context);
    hospitalBloc.add(LoadHospitalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<HospitalBloc, HospitalState>(
        builder: (context, state) {
          if (state is HospitalInitialState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HospitalLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HospitalFailedState) {
            return Center(
              child: Column(
                children: [
                  Text(
                    "Failed to download hospitals",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  MaterialButton(
                    color: Colors.red[400],
                    child: Text("Failed to download hospitals"),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          } else if (state is HospitalLoadedState) {
            return BuildList(state.hospitals);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Widget BuildList(List<Hospital> hospitals) {
  return ListView.builder(
    itemCount: hospitals.length,
    itemBuilder: (ctx, pos) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: ListTile(
            title: Text(hospitals[pos].name),
            subtitle: Text(hospitals[pos].tel),
          ),
          onTap: () {},
        ),
      );
    },
  );
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

const MaterialColor kPrimaryColor = const MaterialColor(
  0xff5f4bbb,
  const <int, Color>{
    50: const Color(0xff5f4bbb),
    100: const Color(0xff5f4bbb),
    200: const Color(0xff5f4bbb),
    300: const Color(0xff5f4bbb),
    400: const Color(0xff5f4bbb),
    500: const Color(0xff5f4bbb),
    600: const Color(0xff5f4bbb),
    700: const Color(0xff5f4bbb),
    800: const Color(0xff5f4bbb),
    900: const Color(0xff5f4bbb),
  },
);
