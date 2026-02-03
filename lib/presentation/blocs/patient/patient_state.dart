import '../../../domain/entities/patient_entity.dart';
import '../../../domain/entities/lab_result_entity.dart';
import '../../../domain/entities/radiology_entity.dart';
import '../../../domain/entities/diagnosis_entity.dart';
import '../../../domain/entities/treatment_entity.dart';

/// Sealed class representing all possible states for the Patient feature.
///
/// States follow the pattern: Initial → Loading → Loaded/Error
/// All states are immutable and descriptive.
sealed class PatientState {
  const PatientState();
}

/// Initial state before any data fetch.
class PatientInitial extends PatientState {
  const PatientInitial();
}

/// Loading state while fetching patient data.
class PatientLoading extends PatientState {
  const PatientLoading();
}

/// Loaded state containing all patient medical data.
class PatientLoaded extends PatientState {
  final PatientEntity patient;
  final List<LabResultEntity> labResults;
  final List<RadiologyEntity> radiologyResults;
  final List<DiagnosisEntity> diagnosis;
  final List<TreatmentEntity> treatment;

  const PatientLoaded({
    required this.patient,
    this.labResults = const [],
    this.radiologyResults = const [],
    this.diagnosis = const [],
    this.treatment = const [],
  });

  /// Creates a copy with updated fields.
  PatientLoaded copyWith({
    PatientEntity? patient,
    List<LabResultEntity>? labResults,
    List<RadiologyEntity>? radiologyResults,
    List<DiagnosisEntity>? diagnosis,
    List<TreatmentEntity>? treatment,
  }) {
    return PatientLoaded(
      patient: patient ?? this.patient,
      labResults: labResults ?? this.labResults,
      radiologyResults: radiologyResults ?? this.radiologyResults,
      diagnosis: diagnosis ?? this.diagnosis,
      treatment: treatment ?? this.treatment,
    );
  }
}

/// Error state containing error message.
class PatientError extends PatientState {
  final String message;

  const PatientError(this.message);
}
