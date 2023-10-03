import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:event_hub/data/repositories/events_repository.dart';
import 'package:meta/meta.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit() : super(const CreateEventState());
  void createEvent({
    required String name,
    required String description,
    required DateTime date,
    required String startTime,
    required String endTime,
    required String location,
    required File image,
    required String capacity,
    required String price,
  }) async {
    emit(CreateEventLoading());
    final resposne = await EventRepository().createEvent(
      name: name,
      description: description,
      date: date,
      startTime: startTime,
      endTime: endTime,
      address: location,
      image: image,
      capacity: capacity,
      price: price,
    );
    if (resposne['success'] == true) {
      emit(CreateEventSuccess(resposne['message']));
    } else {
      emit(CreateEventError(resposne['message']));
    }
  }
}
