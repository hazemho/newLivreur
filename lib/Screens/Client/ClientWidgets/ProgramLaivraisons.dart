import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../Providers/SommaireDetailsProvider.dart';

class ProgramLaivraisons extends StatefulWidget {
  const ProgramLaivraisons({super.key});

  @override
  State<ProgramLaivraisons> createState() => _ProgramLaivraisonsState();
}

class _ProgramLaivraisonsState extends State<ProgramLaivraisons> {
  String dateColis = '';
  String timeColis = '';
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(Icons.calendar_month),
                    label: Text(
                      '${dateTime.year}/${dateTime.month}/${dateTime.day}',
                      style: myTextStyleBase.bodyText2,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(Icons.timer),
                    label: Text(
                      '$hours:$minutes',
                      style: myTextStyleBase.bodyText2,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            child: Text('Choisir la date de livraison'),
            onPressed: () {
              pickDateTime().then((value) {
                setState(() {});
              });
            }),
      ],
    ));
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;
    var dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() => this.dateTime = dateTime);

    setState(() => dateColis = DateFormat('dd/MM/yy').format(dateTime));
    Provider.of<SommaireDetailsProvider>(context, listen: false).PickDateColis(dateColis);

    setState(() => timeColis = DateFormat('hh:mm').format(dateTime));
    Provider.of<SommaireDetailsProvider>(context, listen: false).PickTimeColis(timeColis);

    debugPrint("Selected Date: ${DateFormat('dd/MM/yy').format(dateTime)} ${DateFormat('hh:mm').format(dateTime)}");

  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context, initialDate: dateTime,
      firstDate: DateTime(1900), lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime() => showTimePicker(context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
