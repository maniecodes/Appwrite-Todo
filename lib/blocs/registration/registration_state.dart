part of 'registration_bloc.dart';

@immutable
class RegistrationState {
  final bool isNameValid;
  final bool isPhoneNumberValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String isError;

  bool get isFormValid =>
      isNameValid && isPhoneNumberValid && isEmailValid && isPasswordValid;

  RegistrationState(
      {@required this.isNameValid,
      @required this.isPhoneNumberValid,
      @required this.isEmailValid,
      @required this.isPasswordValid,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
      this.isError});

  factory RegistrationState.empty() {
    return RegistrationState(
      isNameValid: true,
      isPhoneNumberValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegistrationState.loading() {
    return RegistrationState(
      isNameValid: true,
      isPhoneNumberValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegistrationState.failure(String error) {
    return RegistrationState(
        isNameValid: true,
        isPhoneNumberValid: true,
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        isError: error);
  }

  factory RegistrationState.success() {
    return RegistrationState(
      isNameValid: true,
      isPhoneNumberValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegistrationState update({
    bool isNameValid,
    bool isPhoneNumberValid,
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegistrationState copyWith({
    bool isNameValid,
    bool isPhoneNumberValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegistrationState(
      isNameValid: isNameValid ?? this.isNameValid,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegistrationState {
      isNameValid: $isNameValid,
      isPhoneNumberValid: $isPhoneNumberValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
