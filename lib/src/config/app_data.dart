import '../models/task_model.dart';

TaskModel task = TaskModel(
    id: 1,
    description: 'Comprar comida para o Januário',
    status: 'pending',
    createAt: '2024-04-01T13:05:44.000Z'
);

TaskModel task2 = TaskModel(
    id: 2,
    description: 'Comer um bolo',
    status: 'pending',
    createAt: '2024-04-01T21:05:44.000Z'
);

TaskModel task3 = TaskModel(
    id: 3,
    description: 'Comer dois bolos',
    status: 'complete',
    createAt: '2024-04-01T12:05:44.000Z'
);

TaskModel task4 = TaskModel(
    id: 4,
    description: 'Pedir café para o vizinho',
    status: 'complete',
    createAt: '2024-04-01T16:05:44.000Z'
);

List<TaskModel> items = [
  task,
  task2,
  task3,
  task4,
];