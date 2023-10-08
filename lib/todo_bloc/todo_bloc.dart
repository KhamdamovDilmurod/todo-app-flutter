import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../database/todo_repository.dart';
import '../models/todo_model.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  final TodoRepository _repository = TodoRepository();

  TodoBloc() : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchAllTodoEvent>(_fetchAllTodo);
    on<InsertTodoEvent>(_insertTodo);
  }

  void _fetchAllTodo(FetchAllTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await _repository.fetchAllTodos();
      emit(FetchAllTodoState(todos));
    } catch (e) {
      print(e.toString());
      emit(TodoError(e.toString()));
    }
  }

  void _insertTodo(InsertTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await _repository.insertTodo(event.todo);
      emit(TodoInsertState(event.todo));
    } catch (e) {
      print(e.toString());
      emit(TodoError(e.toString()));
    }
  }
}
