import 'package:flutter/material.dart';

import '../../models/enums/task_status.dart';

Color getStatusColor(TaskStatus status) {
  switch (status) {
    case TaskStatus.todo:
      return Colors.grey.shade300;
    case TaskStatus.inProgress:
      return Colors.orange.shade300;
    case TaskStatus.done:
      return Colors.green.shade300;
  }
}
