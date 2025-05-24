import 'package:evently_app/core/extensions/date_extention.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
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

import '../../core/resources/constant_manager.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  CategoryDM selectedCategory = ConstantManager.categoriesWithoutAll[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.create_event),
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(selectedCategory.imagePath!),
              ),
              CustomTabBar(
                  onCategoryTabClicked: _onCategoryItemClicked,
                  verticalPadding: 16,
                  categories: ConstantManager.categoriesWithoutAll,
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
                    "${selectedTime.hour}-${selectedTime.minute}",
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
                title: AppLocalizations.of(context)!.add_event,
                onPress: _createEvent,
              ),
            ],
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
    try {
      EventDM event = EventDM(
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate.copyWith(
            hour: selectedTime.hour, minute: selectedTime.minute),
      );
      await FirebaseServices.addEventToFireStore(event);
      Navigator.pop(context);
    } catch (exception) {
      print(exception.toString());
    }
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
    setState(() {});
  }
}
