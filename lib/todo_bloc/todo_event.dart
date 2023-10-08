part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllTodoEvent extends TodoEvent {}

class InsertTodoEvent extends TodoEvent {
  final TodoModel todo;

  InsertTodoEvent({required this.todo});
}

class UpdateTodoEvent extends TodoEvent {
  final TodoModel todo;

  UpdateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final int todoId;

  DeleteTodoEvent(this.todoId);
}
