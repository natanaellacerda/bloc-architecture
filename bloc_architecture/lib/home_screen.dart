import 'package:bloc_architecture/food.dart';
import 'package:bloc_architecture/home_bloc.dart';
import 'package:bloc_architecture/home_event.dart';
import 'package:bloc_architecture/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late HomeBloc bloc;

  @override

  void initState() {
    super.initState();
    bloc = context.read<HomeBloc>();
  }

  Widget _buildFoodCard(Food food) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                ),
                child: Image.network(
                  food.thumbnailURL,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 1,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  food.price,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            const Expanded(
                                flex: 0,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.blueAccent,
                                ))
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: const Text("Cool App")),
          body: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const CircularProgressIndicator();
              }
              if (state is HomeSucessFetchDataState) {
                return Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildFoodCard(state.foods[index]);
                    },
                    itemCount: state.foods.length,
                  ),
                );
              }
              if (state is HomeErrorFetchDataState) {
                return Center(
                  child: Column(
                    children: [
                      Text(state.errorMessage),
                      ElevatedButton(
                        child: const Text("Fetch Data"),
                        onPressed: () {
                          bloc.add(FetchDataEvent());
                        },
                      )
                    ],
                  ),
                );
              }

              return Center(
                child: ElevatedButton(
                  child: const Text("Fetch Data"),
                  onPressed: () {
                    bloc.add(FetchDataEvent());
                  },
                ),
              );
            },
          )),
    );
  }
}
