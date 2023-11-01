const String strSeparator = ",";

String convertArrayToString(List<String> array,
    {String separator = strSeparator}) {
  return array.join(separator);
}

List<String> convertStringToArray(String str,
    {String separator = strSeparator}) {
  return str.split(separator);
}
