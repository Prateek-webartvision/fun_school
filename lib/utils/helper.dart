timeCheck({required DateTime yourTime}) {
  final now = DateTime.now();
  final diff = now.difference(yourTime.toLocal());
  if (diff.inSeconds < 60) {
    return "just now";
  }
  if (diff.inMinutes <= 60) {
    return "${diff.inMinutes}m";
  }
  if (diff.inHours <= 24) {
    return "${diff.inHours}h";
  }
  return "${diff.inDays}d";
}

// get Week Day
// String getWeekDay(int day, {bool inSort = false}) {
//   String tempDay;

//   switch (day) {
//     case DateTime.monday:
//       tempDay = "Monday";
//       break;
//     case DateTime.tuesday:
//       tempDay = "Tuesday";
//       break;
//     case DateTime.wednesday:
//       tempDay = "Wednesday";
//       break;
//     case DateTime.thursday:
//       tempDay = "Thursday";
//       break;
//     case DateTime.friday:
//       tempDay = "Friday";
//       break;
//     case DateTime.saturday:
//       tempDay = "Saturday";
//       break;
//     case DateTime.sunday:
//       tempDay = "Sunday";
//       break;
//     default:
//       tempDay = "Not a weekDay";
//   }

//   if (inSort) {
//     if (day > 7) {
//       return tempDay;
//     } else {
//       return tempDay.substring(0, 3);
//     }
//   } else {
//     return tempDay;
//   }
// }

DateTime getDateFromTimestemp10(String timeStemp) {
  return DateTime.fromMicrosecondsSinceEpoch(int.parse(timeStemp) * 1000000);
}
