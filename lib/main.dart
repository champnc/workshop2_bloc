import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop2_bloc/bloc/hospital_bloc.dart';
import 'package:workshop2_bloc/data/model/hospitals.dart';
import 'package:workshop2_bloc/data/repository/hospital_repository.dart';
import 'MyObserver.dart';
import 'data/model/my_location.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _myLocation = MyLocation(13.723884, 100.529435);
    return BlocProvider(
      create: (context) => HospitalBloc(
          repository: HospitalsRepositoryImpl(), location: _myLocation),
      child: MaterialApp(
        title: 'Workshop 2 with BLOC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Hospitals'),
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
      appBar: AppBar(backgroundColor: kPrimaryColor,
        title: Text(widget.title),
        centerTitle: true,
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

// ignore: non_constant_identifier_names
Widget BuildList(List<Hospital> hospitals) {
  return ListView.builder(
    itemCount: hospitals.length,
    itemBuilder: (ctx, pos) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20.0,left: 16.0,right: 16.0,top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hospitals[pos].name,
              style: TextStyle(color: kPrimaryColor),
            ),
            Text(
              formatDistance(hospitals[pos].distance),
              style: TextStyle(color: kPrimaryColor),
            )
          ],
        ),
      );
    },
  );
}

String formatDistance(double val) {
  if (val > 1000) {
    var km = (val / 1000);
    return km.toStringAsFixed(km.truncateToDouble() == km ? 0 : 1) + " km";
  } else {
    var m = val;
    return m.toStringAsFixed(m.truncateToDouble() == m ? 0 : 1) + " m";
  }
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
