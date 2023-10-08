import '../models/todo_model.dart';
import 'database_helper.dart';

class TodoRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<TodoModel> insertTodo(TodoModel todoModel) async {
    return await _databaseHelper.insert(todoModel);
  }

  Future<int?> updateTodo(TodoModel todoModel) async {
    return await _databaseHelper.update(todoModel);
  }

  Future<int?> deleteTodo(int todoModelId) async {
    return await _databaseHelper.delete(todoModelId);
  }

  Future<List<TodoModel>> fetchAllTodos() async {
    return await _databaseHelper.getAllTodos();
  }
}
