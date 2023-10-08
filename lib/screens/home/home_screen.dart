import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sqflite_bloc/models/todo_model.dart';

import '../../todo_bloc/todo_bloc.dart';

class HomeScreen extends StatelessWidget {
   var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoBloc>(context)
        .add(FetchAllTodoEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo tak"),
      ),
      body: SingleChildScrollView(
        child:
          Column(
            children: [
              TextFormField(
                controller: textController,
              ),
              ElevatedButton(onPressed: (){
                BlocProvider.of<TodoBloc>(context).add(
                  InsertTodoEvent(todo: TodoModel(textController.text, "desc", "time", "location", 1),
                  ),
                );
                BlocProvider.of<TodoBloc>(context)
                    .add(FetchAllTodoEvent());
              }, child: Text("add")),
              BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TodoError) {
                  return Center(child: Text(state.message));
                }
                if (state is FetchAllTodoState) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.vertical,
                          itemCount: state.todos.length,
                          itemBuilder: (_, position) {
                            var item = state.todos[position];
                            return ListTile(
                              title: Text(item.name),
                            );
                          }),
                    ],)
                  );
                } else {
                  return Container(
                    child: Text("Something went wrong"),
                  );
                }
              }),
            ],
          ),
      ),
    );
  }
}
