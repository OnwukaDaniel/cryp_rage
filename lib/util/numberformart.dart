class NumberFormat {
  static String twoDecimal(String input) {
    if (input.isEmpty) return "0.00";
    var index = input.indexOf(".");
    if (index == -1) return input;
    return double.parse(input).toStringAsFixed(2);
  }

  static String toCurrency(String input) {
    if (input.length <= 1) return input;
    String finalValue = "";
    int dotIndex = input.indexOf(".");
    String decimalPart = "";
    String naturalPart = "";
    if(dotIndex < 0){ // NO DECIMAL
      naturalPart = input;
    } else {
      decimalPart = input.substring(dotIndex, input.length);
      naturalPart = input.substring(0, dotIndex);
    }

    int threeCounts = 0;
    for (int i = naturalPart.length - 1; i >= 0; i--) {
      if (threeCounts == 3) {
        threeCounts = 0;
        finalValue += ",";
      }
      finalValue += naturalPart[i];
      threeCounts++;
    }
    var solution = decimalPart.isNotEmpty
        ? reverse(finalValue)
        : reverse(finalValue) + decimalPart;
    return solution;
  }

  static String reverse(String input) {
    String finalValue = "";
    if (input.length <= 1) {
      return input;
    }
    int threeCounts = 0;
    for (int i = input.length - 1; i >= 0; i--) {
      finalValue += input[i];
    }
    return "$finalValue.00";
  }

  static String removeCommaAndDecimal(String input) {
    String finalValue = input;
    finalValue = input.replaceAll(",", "");
    finalValue = finalValue.replaceAll(".00", "");
    return finalValue;
  }
}
