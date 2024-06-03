import 'package:intl/intl.dart';

extension TextExt on String {
  DateTime get fromChatTextToDateTime => DateFormat('dd.MM.yyyy').parse(this);

  DateTime get fromServerTextToDateTime => DateFormat('yyyy-MM-dd').parse(this);

  String get capitalize =>
      isEmpty ? "" : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';

  String get capitalizeFirstOfEach =>
      split(" ").map((str) => str.capitalize).join(" ");

  String get replaceExtraSpaces => replaceAll(RegExp(r"\s\s+"), ' ').trim();

  bool get hasOnlySpaceCharacters => replaceAll(' ', '').isEmpty;

  bool get isCorrectGradeFormat => RegExp(r'^\d+(\.\d{1,3})?$').hasMatch(this);
}

extension AuthTextExt on String {
  bool get isValidEmailFormat => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool get isValidPasswordLength => length >= 8;

  bool get isNotValidCountryNameLength => length < 3;

  bool get isNotValidZipcodeLength => length < 3;

  bool get hasNumbers => RegExp(r'[0-9]').hasMatch(this);

  bool get isOnlySpaces => trim().isEmpty;

  bool get hasSpaces => contains(' ');

  bool get hasSpecialCharacters =>
      RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$]').hasMatch(this);
}

extension UserNameValidation on String {
  String get formattedUserName {
    return replaceAll(RegExp(r'\s\s+'), ' ')
        .replaceAll(RegExp(r'[,.]'), '')
        .trim()
        .split(' ')
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }

  bool get isNotValidUserNameLength => length < 2 || length > 50;

  bool get isValidUserName =>
      !isNotValidUserNameLength &&
      !hasNumbers &&
      !isOnlySpaces &&
      !hasSpecialCharacters;
}

extension CountryNameValidation on String {
  String get formattedCountryName {
    return replaceAll(RegExp(r'\s\s+'), ' ')
        .replaceAll(RegExp(r'[,.]'), '')
        .trim()
        .split(' ')
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }

  bool get isNotValidCountryNameLength => length < 3 || length > 100;

  bool get isValidCountryName =>
      !isNotValidCountryNameLength &&
      !hasNumbers &&
      !isOnlySpaces &&
      !hasSpecialCharacters;
}

extension ZipCodeValidation on String {
  String get formattedZipCode {
    return replaceAll(RegExp(r'\s\s+'), ' ').trim();
  }

  bool get isValidZipCodeLength => length > 3 && length < 10;

  bool get hasDividerCharacters => RegExp(r"[',. -]").hasMatch(this);

  bool get isValidZipCode =>
      isValidZipCodeLength &&
      !hasSpaces &&
      !hasSpecialCharacters &&
      !hasDividerCharacters;
}

extension ConvertExt on String {
  double toDoubleIncludingInt() {
    return (double.tryParse(this) ?? int.tryParse(this)?.toDouble() ?? 0);
  }

  double toDouble() {
    return (double.tryParse(this) ?? 0);
  }
}

extension FileNameExt on String {
  String get fileNameWithoutType {
    final text = split(".");
    text.removeLast();
    return text.join('.');
  }

  String get fileNameFromPath => substring(lastIndexOf('/') + 1);

  String get fileNameFromPathWithoutType =>
      fileNameFromPath.fileNameWithoutType;
}
