

import 'package:flutter_test/flutter_test.dart';
import 'package:todoitico/utils/dateHelpers.dart';

void main() {
  group('inSpanishDate', () {
    test('Should return a well-formated spanish date', (){
     expect('8 de octubre del 2021', DateHelpers.inSpanishDate(DateTime(2021,10,8)));
    });
  });
}