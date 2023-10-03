import 'package:bloc/bloc.dart';
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
}
