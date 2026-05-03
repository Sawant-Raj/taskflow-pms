enum TaskStatus { todo, inProgress, done }

TaskStatus statusFromString(String status) {
  switch (status) {
    case 'todo':
      return TaskStatus.todo;
    case 'in_progress':
      return TaskStatus.inProgress;
    case 'done':
      return TaskStatus.done;
    default:
      return TaskStatus.todo;
  }
}

String statusToString(TaskStatus status) {
  switch (status) {
    case TaskStatus.todo:
      return 'todo';
    case TaskStatus.inProgress:
      return 'in_progress';
    case TaskStatus.done:
      return 'done';
  }
}
