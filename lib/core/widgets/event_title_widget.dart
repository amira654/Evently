import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EventTitleWidget extends StatefulWidget {
  const EventTitleWidget(
      {super.key, required this.event, required this.favEvent});

  final EventDM event;
  final bool favEvent;

  @override
  State<EventTitleWidget> createState() => _EventTitleWidgetState();
}

class _EventTitleWidgetState extends State<EventTitleWidget> {
  late bool isFavorite = widget.favEvent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: REdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: Text(
              widget.event.title,
              style: Theme.of(context).textTheme.labelSmall,
            )),
            IconButton(
                onPressed: _markEventAsFav,
                icon:
                    Icon(isFavorite ? Icons.favorite : Icons.favorite_outline))
          ],
        ),
      ),
    );
  }

  void _markEventAsFav() {
    isFavorite = !isFavorite;
    if (isFavorite) {
      FirebaseServices.addEventToFavourite(widget.event.id);
    } else {
      FirebaseServices.removeEventFromFav(widget.event.id);
    }
    setState(() {});
  }
}
