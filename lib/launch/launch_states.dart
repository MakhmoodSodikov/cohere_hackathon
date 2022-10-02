import 'package:equatable/equatable.dart';
import 'package:video_club/models/Result.dart';

abstract class LaunchState extends Equatable {}

class InitState extends LaunchState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends LaunchState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends LaunchState {
  LoadedState({required this.result});
  final Result result;

  @override
  List<Object?> get props => [result];
}
