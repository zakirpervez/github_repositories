import 'dart:math';

import '../../database/app_database.dart';
import '../../remote/config.dart';
import '../../res/dimen_constant.dart';

abstract class BaseUseCase {}

class CommitsBaseUseCase implements BaseUseCase {
  bool checkIfAtLeast12HoursApart(AuditData? auditData) {
    if (auditData == null) {
      return true;
    }
    DateTime now = DateTime.now();
    Duration difference = now.difference(auditData.updatedAt!);
    return difference.inHours >= Dimen.magic12;
  }

  AuditData getCommitsAudit(List<AuditData> auditRecords, String repoNodeId) {
    AuditData auditTableData;
    if (auditRecords.isNotEmpty) {
      auditTableData = auditRecords.firstWhere((element) =>
      repoNodeId == element.nodeId &&
          Config.commits == element.apiEndPointName);
    } else {
      int randomId = Random().nextInt(1000000);
      auditTableData = AuditData(
        id: randomId,
        nodeId: repoNodeId,
        apiEndPointName: Config.commits,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
    return auditTableData;
  }
}
