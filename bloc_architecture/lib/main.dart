import 'package:bloc_architecture/home_bloc.dart';
import 'package:bloc_architecture/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomeScreen()
    )
  );
}

