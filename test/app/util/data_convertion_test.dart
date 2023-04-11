import 'package:app_flutter/app/util/date_convertion.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

    test('data desformatada', () {
      String inputDate = '17/06/2023';
      String expectedDate = '2023-06-17 00:00:00.000';

      String unformattedDate = ControllersFunction.desvormataData(inputDate);

      expect(unformattedDate, expectedDate);
    });

}
