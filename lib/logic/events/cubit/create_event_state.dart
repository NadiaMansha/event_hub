part of 'create_event_cubit.dart';

@immutable
class CreateEventState {
  const CreateEventState();
}

class CreateEventLoading extends CreateEventState {}

class CreateEventSuccess extends CreateEventState {
  final String message;
  const CreateEventSuccess(this.message);
}

class CreateEventError extends CreateEventState {
  final String message;
  const CreateEventError(this.message);
}
