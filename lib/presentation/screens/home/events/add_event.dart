import 'dart:io';

import 'package:event_hub/constants/app_colors.dart';
import 'package:event_hub/widgets/button.dart';
import 'package:event_hub/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/helpers/show_time_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../logic/events/cubit/create_event_cubit.dart';
import '../../../../widgets/custom_date_picker.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  DateTime? dateTime;
  String? startTime;
  String? endTime;
  final TextEditingController controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer(
          bloc: BlocProvider.of<CreateEventCubit>(context),
          listener: (context, state) {
            if (state is CreateEventSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is CreateEventError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ],
                  ),
                  const Text('Add an Event',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: image == null
                        ? GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                              height: 200,
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: const Center(
                                child: Text('selet Image'),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.file(
                              File(image!.path).absolute,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  TextInput(
                    hintText: 'Event Name',
                    obscureText: false,
                    controller: _nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    hintText: 'Description',
                    obscureText: false,
                    controller: _descriptionController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Select Date",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      await _modalBottomSheetMenu((date) {
                        controllerDate.text = date.toString().split(" ").first;
                        if (date != null) {
                          setState(() {
                            dateTime = date;
                          });
                        }
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 7, right: 5),
                      width: size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controllerDate,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Date",
                              ),
                            ),
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: AppColors().primary,
                            size: size.width * 0.08,
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Time",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.045),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 7, right: 5),
                        width: size.width * 0.43,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                TimeOfDay? selectedTime =
                                    await showMaterialTimePicker(
                                  context: context,
                                  selectedTime: TimeOfDay.now(),
                                );

                                if (selectedTime != null) {
                                  String formattedTime = '';
                                  if (selectedTime.hour.toString().length ==
                                      1) {
                                    formattedTime += '0${selectedTime.hour}:';
                                  } else {
                                    formattedTime += '${selectedTime.hour}:';
                                  }

                                  if (selectedTime.minute.toString().length ==
                                      1) {
                                    formattedTime += '0${selectedTime.minute}';
                                  } else {
                                    formattedTime += '${selectedTime.minute}';
                                  }

                                  formattedTime +=
                                      selectedTime.period == DayPeriod.pm
                                          ? ' PM'
                                          : ' AM';

                                  setState(() {
                                    startTime = formattedTime;
                                  });
                                }

                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: Text(
                                startTime ?? "Start time",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.045),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  startTime = null;
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: size.width * 0.08,
                                )),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 7, right: 5),
                        width: size.width * 0.43,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                TimeOfDay? selectedTime =
                                    await showMaterialTimePicker(
                                  context: context,
                                  selectedTime: TimeOfDay.now(),
                                );

                                if (selectedTime != null) {
                                  String formattedTime = '';
                                  if (selectedTime.hour.toString().length ==
                                      1) {
                                    formattedTime += '0${selectedTime.hour}:';
                                  } else {
                                    formattedTime += '${selectedTime.hour}:';
                                  }

                                  if (selectedTime.minute.toString().length ==
                                      1) {
                                    formattedTime += '0${selectedTime.minute}';
                                  } else {
                                    formattedTime += '${selectedTime.minute}';
                                  }

                                  formattedTime +=
                                      selectedTime.period == DayPeriod.pm
                                          ? ' PM'
                                          : ' AM';

                                  setState(() {
                                    endTime = formattedTime;
                                  });
                                }

                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: Text(
                                endTime ?? "End time",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.045),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                endTime = null;
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                                size: size.width * 0.08,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    prefixIcon: Image.asset('assets/images/location.png',
                        width: 25, height: 30, color: AppColors().primary),
                    hintText: 'Event Location',
                    obscureText: false,
                    controller: _locationController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    hintText: 'Event Price',
                    obscureText: false,
                    controller: _priceController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    hintText: 'Event Capacity',
                    obscureText: false,
                    controller: _capacityController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    title: 'Submit',
                    onPressed: () {
                      BlocProvider.of<CreateEventCubit>(context).createEvent(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        date: dateTime!,
                        startTime: startTime!,
                        endTime: endTime!,
                        location: _locationController.text,
                        image: File(image!.path),
                        capacity: _capacityController.text,
                        price: _priceController.text,
                      );
                    },
                    backgroundColor: AppColors().primary,
                    foregroundColor: Colors.white,
                    isLoading: state is CreateEventLoading ? true : false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  Future<void> _modalBottomSheetMenu(Function(DateTime?) onTap) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return SizedBox(
              height: 400,
              child: CustomDatePickerScreen(
                onTap: onTap,
              ));
        });
  }
}
