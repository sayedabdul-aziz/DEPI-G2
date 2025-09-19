import 'package:counter_with_cubit/bloc/counter_bloc.dart';
import 'package:counter_with_cubit/bloc/counter_event.dart';
import 'package:counter_with_cubit/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text('Counter Screen', style: TextStyle(color: Colors.white)),
        ),
        body: BlocConsumer<CounterBloc, CounterBlocState>(
          listener: (context, state) {
            if (state is CounterAddedState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Counter Added')));
            }
          },
          builder: (context, state) {
            var bloc = context.read<CounterBloc>();
            if (state is CounterLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${bloc.counter}", style: TextStyle(fontSize: 40)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        bloc.add(IncrementEvent());
                      },
                      icon: Icon(Icons.add),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        bloc.add(DecrementEvent());
                      },
                      icon: Icon(Icons.remove, color: Colors.white),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
