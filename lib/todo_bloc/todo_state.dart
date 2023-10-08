part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoError extends TodoState {
  String message;

  TodoError(this.message);

  @override
  List<Object?> get props => [message];
}

class TodoLoading extends TodoState {
  TodoLoading();

  @override
  List<Object?> get props => [];
}

class FetchAllTodoState extends TodoState{
  final List<TodoModel> todos;
  FetchAllTodoState(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodoInsertState extends TodoState{
  final TodoModel todo;
  TodoInsertState(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoUpdateState extends TodoState{
  final TodoModel todo;
  TodoUpdateState(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoDeleteState extends TodoState{
  TodoDeleteState();

  @override
  List<Object?> get props => [];}
