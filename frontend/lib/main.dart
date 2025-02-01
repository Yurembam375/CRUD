import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/dependency%20injection/locator.dart';
import 'package:frontend/logic/bloc/person_bloc_bloc.dart';
import 'package:frontend/logic/bloc/person_bloc_event.dart';
import 'package:frontend/persentation/screen/HomeScreen.dart';

void main() {
  setupLocator(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<PersonBloc>()..add(FetchPersons()), // Inject Bloc
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
