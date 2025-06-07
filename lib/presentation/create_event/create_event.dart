import 'package:evently_app/core/extensions/date_extention.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/resources/constant_manager.dart';
import '../../data/DM/userDM.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key, this.event});

  final EventDM? event;
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _initEditData();
  }

  _initEditData() {
    if (widget.event != null) {
      titleController.text = widget.event!.title!;
      descriptionController.text = widget.event!.description!;
      selectedCategory = widget.event!.category!;
      selectedDate = widget.event!.dateTime!;
      selectedTime = TimeOfDay(
          hour: widget.event!.dateTime!.hour,
          minute: widget.event!.dateTime!.minute);
      location =  LatLng(widget.event!.lat!, widget.event!.lng!);

    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  CategoryDM selectedCategory = ConstantManager.categories[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  LatLng? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.event == null ? Text("Create Event") : Text("Edit Event"),
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(selectedCategory.imagePath!),
                ),
                CustomTabBar(
                  initialIndex: ConstantManager.categories.indexOf(selectedCategory) ,
                    onCategoryTabClicked: _onCategoryItemClicked,
                    verticalPadding: 16,
                    categories: ConstantManager.categories,
                    selectedTabBg: ColorsManager.blue,
                    unselectedTabBg: Colors.transparent,
                    selectedLabelColor: ColorsManager.light,
                    unselectedLabelColor: ColorsManager.blue),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFormField(
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "plz, enter title.";
                      }
                      return null;
                    },
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    hint: AppLocalizations.of(context)!.event_title,
                    prefixIcon: Icons.edit_note_outlined),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFormField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "plz, enter description.";
                    }
                    if (input.length < 6) {
                      return "sorry, description should be at least 6 character.";
                    }
                    return null;
                  },
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  hint: AppLocalizations.of(context)!.event_description,
                ),
                Row(
                  children: [
                    const Icon(Icons.date_range),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: Text(
                      selectedDate.toFormattedDate,
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                    CustomTextButton(
                        title: AppLocalizations.of(context)!.choose_date,
                        onPress: _showEventDate)
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: Text(
                      selectedDate.getTime,
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                    CustomTextButton(
                        title: AppLocalizations.of(context)!.choose_time,
                        onPress: _showEventTime)
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomElevatedButton(
                  title: location == null
                      ? "select location"
                      : "${location!.latitude},${location!.longitude}",
                  onPress: () {
                    Navigator.pushNamed(context, RoutesManager.selectedLocation)
                        .then((value) {
                      if (value != null && mounted) {
                        setState(() {
                          location = value as LatLng;
                        });
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomElevatedButton(
                  title: widget.event == null
                      ? "Create Event" : "Update Event",
                  onPress:widget.event == null ? _createEvent : _updateEvent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCategoryItemClicked(CategoryDM category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _createEvent() async {
    if (!formKey.currentState!.validate()) return;
    try {
      EventDM event = EventDM(
        userId: UserDM.currentUser!.id,
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        lat: location?.latitude,
        lng: location?.longitude,
        dateTime: selectedDate.copyWith(
            hour: selectedTime.hour, minute: selectedTime.minute),
      );
      await FirebaseServices.addEventToFireStore(event);
      Navigator.pop(context);
    } catch (exception) {
      print(exception.toString());
    }
  }
  _updateEvent() async {
    EventDM event = EventDM(
      userId: UserDM.currentUser!.id,
      id: widget.event!.id,
      category: selectedCategory,
      title: titleController.text,
      description: descriptionController.text,
      lat: location?.latitude,
      lng: location?.longitude,
      dateTime: selectedDate.copyWith(
          hour: selectedTime.hour, minute: selectedTime.minute),
    );

    await FirebaseServices.updateEvent(event).then((value) {
      print("event updated");
      Navigator.pop(context);
    });

  }

  void _showEventDate() async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }

  void _showEventTime() async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
            selectedTime;
    selectedDate = selectedDate.copyWith(
        hour: selectedTime.hour, minute: selectedTime.minute);
    setState(() {});
  }
}
