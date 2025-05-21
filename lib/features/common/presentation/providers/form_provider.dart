import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/logger/app_logging.dart';
import 'package:reactive_forms/reactive_forms.dart';

final formProvider = StateNotifierProvider<FormNotifier, FormState>(
  (ref) => FormNotifier(),
);

class FormNotifier extends StateNotifier<FormState> {
  FormNotifier() : super(FormState());

  void setFormGroup(FormGroup newFormGroup) {
    newFormGroup.valueChanges.listen((_) => _updateFormState());
    newFormGroup.statusChanged.listen((_) => _updateFormState());

    state = state.copyWith(formGroup: newFormGroup, isInitialized: true);
    _updateFormState();
  }

  void validateForm() {
    if (state.formGroup != null) {
      state.formGroup!.markAllAsTouched();
      _updateFormState();
    }
  }

  void _updateFormState() {
    if (state.formGroup != null) {
      state = state.copyWith(
        isValid: state.formGroup!.valid,
        formValues: state.formGroup!.value,
      );
    }
  }

  void resetForm() {
    if (state.formGroup != null) {
      state.formGroup!.reset();
      _updateFormState();
    }
  }

  Future<T> submitForm<T>(Future<T> Function() onSubmit) async {
    state = state.copyWith(isSubmissionInProgress: true);
    validateForm();
    if (state.isValid) {
      try {
        final result = await onSubmit();
        state = state.copyWith(isSubmissionInProgress: false);
        _updateFormState();
        return result;
      } catch (e) {
        logger.e(error: e, message: 'Error submitting form');
      }
    }
    state = state.copyWith(isSubmissionInProgress: false);
    _updateFormState();
    throw Exception('Form is not valid');
  }

  bool get isValid => state.isValid;

  Map<String, Object?> get formValues => state.formValues;

  FormGroup? get formGroup => state.formGroup;
}

class FormState {
  final FormGroup? formGroup;
  final bool isValid;
  final Map<String, Object?> formValues;
  final bool isInitialized;
  final bool isSubmissionInProgress;

  FormState({
    this.formGroup,
    this.isValid = false,
    this.formValues = const {},
    this.isInitialized = false,
    this.isSubmissionInProgress = false,
  });

  FormState copyWith({
    FormGroup? formGroup,
    bool? isValid,
    Map<String, Object?>? formValues,
    bool? isInitialized,
    bool? isSubmissionInProgress,
  }) {
    return FormState(
      formGroup: formGroup ?? this.formGroup,
      isValid: isValid ?? this.isValid,
      formValues: formValues ?? this.formValues,
      isInitialized: isInitialized ?? this.isInitialized,
      isSubmissionInProgress: isSubmissionInProgress ?? this.isSubmissionInProgress,
    );
  }
}
