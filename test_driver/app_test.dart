import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tic Tac Toe App', () {
    final button = find.text('LOG IN');

    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Giver app is ran When clicking button Then new page appears', () async {
      await driver?.tap(button);

      final text = find.text('Email');

      expect(await driver?.getText(text), 'Email');
    });
  });
}
