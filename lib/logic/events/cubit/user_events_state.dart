part of 'user_events_cubit.dart';

@immutable
class UserEventsState {
  const UserEventsState();
}

class UpcomingEventsLoading extends UserEventsState {}

class UpcomingEventsLoaded extends UserEventsState {
  final List<Event> events;
  const UpcomingEventsLoaded({required this.events});
}

class UpcomingEventsError extends UserEventsState {
  final String message;
  const UpcomingEventsError({required this.message});
}

class PastEventsLoading extends UserEventsState {}

class PastEventsLoaded extends UserEventsState {
  final List<Event> events;
  const PastEventsLoaded({required this.events});
}

class PastEventsError extends UserEventsState {
  final String message;
  const PastEventsError({required this.message});
}
