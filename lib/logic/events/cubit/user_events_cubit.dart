import 'package:bloc/bloc.dart';
import 'package:event_hub/data/repositories/events_repository.dart';
import 'package:meta/meta.dart';

import '../../../data/models/event.dart';

part 'user_events_state.dart';

class UserEventsCubit extends Cubit<UserEventsState> {
  UserEventsCubit() : super(const UserEventsState());
  //get upcoming events
  Future<void> getUpcomingEvents() async {
    emit(UpcomingEventsLoading());
    try {
      final List<Event> events = await EventRepository().getUpcomingEvents();
      emit(UpcomingEventsLoaded(events: events));
    } catch (e) {
      emit(UpcomingEventsError(message: e.toString()));
    }
  }

  //get past events
  Future<void> getPastEvents() async {
    emit(PastEventsLoading());
    try {
      final List<Event> events = await EventRepository().getPastEvents();
      emit(PastEventsLoaded(events: events));
    } catch (e) {
      emit(PastEventsError(message: e.toString()));
    }
  }
}
