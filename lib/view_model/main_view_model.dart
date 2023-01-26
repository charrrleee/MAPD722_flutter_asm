
import '../framework.dart';

class MainViewModel extends BaseViewModel {
  int numbersOfHour = 0;
  double hourlyRate = 0.0;
  double regularPay = 0.0;
  double overtimePay = 0.0;
  double tax = 0.0;
  List<String> list = [];
  String _report = "";
  bool calculated = false;

  String get report => _report;

  calculate() {
    if (numbersOfHour <= 0 || hourlyRate <= 0) {
      return;
    }
    calculated = true;
    if (numbersOfHour <= 40) {
      regularPay = numbersOfHour * hourlyRate;
    } else {
      regularPay = 40 * hourlyRate;
      overtimePay = (numbersOfHour - 40) * hourlyRate * 1.5;
    }
    tax = (overtimePay + regularPay) * 0.18;
    notifyListeners();
    _updateReport();
  }

  _updateReport() {
    list = [
      "Report",
      "regular pay : $regularPay",
      "overtime pay: $overtimePay",
      "total pay: ${overtimePay + regularPay}",
      "tax: $tax"
    ];

    _report = list.join("\n");
    notifyListeners();
  }

  getAbout() {
    return "Pui Yan Cheung\n 301252393";
  }

  onChangeNumbersOfHour(String value) {
    numbersOfHour = int.parse(value);
    notifyListeners();
  }

  onChangeHourlyRate(String value) {
    hourlyRate = double.parse(value);
    notifyListeners();
  }

  validateNumbersOfHour(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  validateHourlyRate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
