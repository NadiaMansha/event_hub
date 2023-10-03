part of 'event_cubit.dart';

@immutable
class EventState {
  const EventState();
}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final AllEvents allEvents;
  const EventLoaded(this.allEvents);
}

class EventError extends EventState {
  final String message;
  const EventError(this.message);
}
