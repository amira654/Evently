import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/resources/constant_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/DM/userDM.dart';
import 'package:evently_app/data/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_event.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryDM selectedCategory = ConstantManager.categoriesWithAll[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              )),
          child: Padding(
            padding:
                REdgeInsets.only(bottom: 16.0, top: 30, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  UserDM.currentUser!.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: ColorsManager.white,
                    ),
                    Text(
                      "Cairo, Egypt",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTabBar(
                  categories: ConstantManager.categoriesWithAll,
                  selectedTabBg: ColorsManager.light,
                  unselectedTabBg: Colors.transparent,
                  selectedLabelColor: ColorsManager.blue,
                  unselectedLabelColor: ColorsManager.light,
                  onCategoryTabClicked: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        StreamBuilder(
          stream: FirebaseServices.getEventsRealTimeUpdates(selectedCategory),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Text("error");
            }
            List<EventDM> events = snapshot.data ?? [];
            return Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                     Navigator.pushNamed(context, RoutesManager.eventDetails,
                       arguments: events[index],  
                     );
                    },
                    child: CustomEvent(
                      event: events[index],
                      favEvent: UserDM.currentUser!.favouriteEventsId
                          .contains(events[index].id),
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
