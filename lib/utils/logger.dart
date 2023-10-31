import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

Logger getLogger(String className) {
  return Logger(printer: CustomLogPrinter(className));
}

class CustomLogPrinter extends LogPrinter {
  final String className;

  CustomLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.defaultLevelColors[event.level];
    var emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy kk:mm:ss.SSS').format(now);
    return [color!('$formattedDate $emoji - [$className]: ${event.message}')];
  }
}
