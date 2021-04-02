import 'package:flutter/material.dart';
import 'package:workshop2_bloc/bloc/hospital_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
      create: (context) => HospitalBloc(),
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

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<HospitalBloc, HospitalState>(
        builder: (context, state) {
          if (state is HospitalInitial) {
            return Center(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: const Center(child: Text('Entry A')),
                  ),
                ],
              ),
            );
          } else if (state is HospitalLoading) {
            return LoaderOverlay(
              useDefaultLoading: true,
              child: ListView(
                children: <Widget>[],
              ),
            );
          } else if (state is HospitalFailed) {
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
          } else {
            return Center(
              child: ListView(
                children: <Widget>[],
              ),
            );
          }
        },
      ),
    );
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
