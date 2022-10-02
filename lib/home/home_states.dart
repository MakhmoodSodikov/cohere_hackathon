import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class InitState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends HomeState {
  LoadedState({required this.generatedText});
  final String generatedText;

  @override
  List<Object?> get props => [generatedText];
}
