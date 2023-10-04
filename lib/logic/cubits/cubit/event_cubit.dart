import 'package:bloc/bloc.dart';
import 'package:event_hub/data/models/bookmark.dart';
import 'package:event_hub/data/models/event.dart';
import 'package:event_hub/data/repositories/events_repository.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../data/models/all_events.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventLoading());

  //get all events
  Future<void> getAllEvents() async {
    emit(EventLoading());
    try {
      final AllEvents allEvents = await EventRepository().getAllEvents();
      emit(EventLoaded(allEvents));
    } catch (e) {
      print(e.toString());
      emit(EventError(e.toString()));
    }
  }

  //boookmark event
  Future<void> bookmarkEvent({required String id}) async {
    emit(EventLoading());
    try {
      await EventRepository().bookmarkEvent(eventId: id);
    } catch (e) {
      print(e.toString());
      emit(EventError(e.toString()));
    }
  }

  //get bookmarked events
  Future<void> getBookmarkedEvents() async {
    emit(BookmarkedEventsLoading());
    try {
      final List<Datum> bookmarks =
          await EventRepository().getBookmarkedEvents();

      emit(BookmarkedEventsLoaded(bookmarks));
    } catch (e) {
      print(e.toString());
      emit(BookmarkedEventsError(e.toString()));
    }
  }
}
