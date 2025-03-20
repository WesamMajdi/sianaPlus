import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/authentication/domain/entities/user_entity.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;

  final String? errorMessage;
  final String? successMessage;

  const AuthState(
      {this.status = AuthStatus.initial,
      this.errorMessage,
      this.user,
      this.successMessage});

  factory AuthState.initial() {
    return const AuthState(
      status: AuthStatus.initial,
      errorMessage: '',
      successMessage: '',
      user: null,
    );
  }

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? successMessage,
    UserEntity? user,
  }) {
    return AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage);
  }

  @override
  List<Object?> get props => [status, errorMessage, successMessage, user];
}
