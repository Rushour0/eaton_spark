part of 'bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState({this.isLoggedIn = false});
  final bool isLoggedIn;

  @override
  List<Object?> get props => [isLoggedIn];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial({super.isLoggedIn});

  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess({this.displayName}) : super(isLoggedIn: true);
  final String? displayName;

  @override
  List<Object?> get props => [displayName];
}

class AuthenticationFailure extends AuthenticationState {
  const AuthenticationFailure() : super(isLoggedIn: false);
  @override
  List<Object?> get props => [];
}

class AuthenticationLogOut extends AuthenticationState {
  const AuthenticationLogOut() : super(isLoggedIn: false);
  @override
  List<Object?> get props => [];
}
