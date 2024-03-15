import 'package:sistema_ies/core/domain/entities/student.dart';

MovementStudentRecord? filterMovementStudentRecordByMoreRecent(
    List<MovementStudentRecord> movements) {
  movements.sort((MovementStudentRecord a, MovementStudentRecord b) =>
      a.date.compareTo(b.date));

  return movements.last;
}
