part of 'language_provider.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {
  const LanguageLoading();
}

class LanguageChanged extends LanguageState {
  const LanguageChanged();
}

class LanguageError extends LanguageState {
  final String message;
  const LanguageError(this.message);

  @override
  List<Object> get props => [message];
}