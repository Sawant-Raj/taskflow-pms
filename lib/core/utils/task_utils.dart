import 'package:flutter/material.dart';

import '../../models/enums/task_status.dart';

Color getStatusColor(TaskStatus status) {
  switch (status) {
    case TaskStatus.todo:
      return Colors.blueGrey.shade600;
    case TaskStatus.inProgress:
      return Colors.orange.shade600;
    case TaskStatus.done:
      return Colors.green.shade600;
  }
}
