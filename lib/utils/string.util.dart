const String strSeparator = ",";

String convertArrayToString(List<String> array, {String separator = strSeparator}) {
  String str = "";
  for (int i = 0; i < array.length; i++) {
    str = str + array[i];
    if (i < array.length - 1) {
      str = str + strSeparator;
    }
  }
  return str;
}

List<String> convertStringToArray(String str, {String separator = strSeparator}) {
  final List<String> arr = str.split(separator);
  return arr;
}
