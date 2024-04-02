const String baseurl = 'https://gc-api-todo.vercel.app/isabela-dranka';

abstract class Endpoints {

  static const String listPendingTask = '$baseurl/todos';
  static const String listCompleteTask = '$baseurl/todos?status=complete';
  static const String createTask = '$baseurl/todos';

  static String viewTask(String id) {
    return '$baseurl/todos/$id';
  }

  static String completeTask(String id) {
    return '$baseurl/todos/$id/complete';
  }

  static String updateTask(String id) {
    return '$baseurl/todos/$id';
  }
}