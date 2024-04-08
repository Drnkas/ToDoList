const String baseurl = 'https://gc-api-todo.vercel.app/isabela-dranka';

abstract class Endpoints {

  static const String listPendingTask = '$baseurl/todos';
  static const String listCompleteTask = '$baseurl/todos?status=complete';
  static const String createTask = '$baseurl/todos';

  static String deleteTask(int id) {
    return '$baseurl/todos/$id';
  }

  static String completeTask(int id) {
    return '$baseurl/todos/$id/complete';
  }

  static String updateTask(int id) {
    return '$baseurl/todos/$id';
  }
}