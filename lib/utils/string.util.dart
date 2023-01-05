const String strSeparator = ",";

String convertArrayToString(List<String> array) {
  String str = "";
  for (int i = 0; i < array.length; i++) {
    str = str + array[i];
    if (i < array.length - 1) {
      str = str + strSeparator;
    }
  }
  return str;
}

List<String> convertStringToArray(String str) {
  final List<String> arr = str.split(strSeparator);
  return arr;
}
