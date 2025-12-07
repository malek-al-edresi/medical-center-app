
import '../entities/radiology_result.dart';

abstract class RadiologyResultRepository {
  Future<List<RadiologyResult>> getRadiologyResults(String invoiceId);
}
