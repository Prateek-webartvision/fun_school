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
  // if (diff.inDays <= 6) {
  //   return "${diff.inDays}d";
  // }

  return "${diff.inDays}d";
}
