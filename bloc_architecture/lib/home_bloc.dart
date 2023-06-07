
import 'dart:math';

import 'package:bloc_architecture/food.dart';
import 'package:bloc_architecture/food_generator.dart';
import 'package:bloc_architecture/home_state.dart';
import 'package:bloc_architecture/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(const HomeInitialState()){
    on<FetchDataEvent> (_onFetchDataEvent);
  }

  void _onFetchDataEvent(
    FetchDataEvent event,
    Emitter<HomeState> emitter
  ) async{
    emitter(const HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    bool isSucceed = Random().nextBool();

    if (isSucceed) {
      List<Food> _dummyFoods = FoodGenerator.generateDummyFoods();
      emitter(HomeSucessFetchDataState(foods: _dummyFoods));
    } else {
      emitter(const HomeErrorFetchDataState(
        errorMessage: "something went very wrong"
        ));
    }
  }
}