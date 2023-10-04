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

class EventBookmarked extends EventState {
  final String message;
  const EventBookmarked(this.message);
}

class EventUnbookmarked extends EventState {
  final String message;
  const EventUnbookmarked(this.message);
}

class BookmarkedEventsLoading extends EventState {}

class BookmarkedEventsLoaded extends EventState {
  final List<Datum> bookmarks;
  const BookmarkedEventsLoaded(this.bookmarks);
}

class BookmarkedEventsError extends EventState {
  final String message;
  const BookmarkedEventsError(this.message);
}
