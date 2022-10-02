import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {}

class InitState extends AccountState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends AccountState {
  LoadingState({required this.account});
  final String account;

  @override
  List<Object?> get props => [account];
}

class LoadedState extends AccountState {
  LoadedState({required this.success});
  final bool success;

  @override
  List<Object?> get props => [success];
}
