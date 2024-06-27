import 'package:design_sync/design_sync.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DesignSync', () {
    const figmaCanvasSize = Size(375, 812);
    const deviceScreenSize = Size(390, 844);

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      final binding = TestWidgetsFlutterBinding.instance;
      binding.window.physicalSizeTestValue = deviceScreenSize;
      binding.window.devicePixelRatioTestValue = 1.0;
      binding.window.platformDispatcher.textScaleFactorTestValue = 1.0;
    });

    tearDown(() {});

    test('Initialization', () {
      DesignSync.initialize(figmaCanvasSize: figmaCanvasSize);
      expect(DesignSync.instance, isNotNull);
    });

    test('Throws StateError when not initialized', () {
      expect(() => DesignSync.instance, throwsStateError);
    });

    group('Dimension adaptations', () {
      setUp(() {
        DesignSync.initialize(figmaCanvasSize: figmaCanvasSize);
      });

      test('adaptWidth', () {
        const figmaWidth = 100.0;
        final expectedWidth =
            figmaWidth * (deviceScreenSize.width / figmaCanvasSize.width);
        expect(DesignSync.instance.adaptWidth(figmaWidth), expectedWidth);
      });

      test('adaptHeight', () {
        const figmaHeight = 200.0;
        final expectedHeight =
            figmaHeight * (deviceScreenSize.height / figmaCanvasSize.height);
        expect(DesignSync.instance.adaptHeight(figmaHeight), expectedHeight);
      });

      test('adaptFontSize', () {
        const figmaFontSize = 16.0;
        final expectedFontSize =
            figmaFontSize * (deviceScreenSize.width / figmaCanvasSize.width);
        expect(
            DesignSync.instance.adaptFontSize(figmaFontSize), expectedFontSize);
      });

      test('adaptRadius', () {
        const figmaRadius = 8.0;
        final expectedRadius =
            figmaRadius * (deviceScreenSize.width / figmaCanvasSize.width);
        expect(DesignSync.instance.adaptRadius(figmaRadius), expectedRadius);
      });
    });

    group('Extension methods', () {
      setUp(() {
        DesignSync.initialize(figmaCanvasSize: figmaCanvasSize);
      });

      test('adaptedWidth', () {
        const figmaWidth = 100.0;
        final expectedWidth =
            figmaWidth * (deviceScreenSize.width / figmaCanvasSize.width);
        expect(figmaWidth.adaptedWidth, expectedWidth);
      });

      test('adaptedHeight', () {
        const figmaHeight = 200.0;
        final expectedHeight =
            figmaHeight * (deviceScreenSize.height / figmaCanvasSize.height);
        expect(figmaHeight.adaptedHeight, expectedHeight);
      });

      test('adaptedFontSize', () {
        const figmaFontSize = 16.0;
        final expectedFontSize =
            figmaFontSize * (deviceScreenSize.width / figmaCanvasSize.width);
        expect(figmaFontSize.adaptedFontSize, expectedFontSize);
      });

      test('adaptedRadius', () {
        const figmaRadius = 8.0;
        final expectedRadius =
            figmaRadius * (deviceScreenSize.width / figmaCanvasSize.width);
        expect(figmaRadius.adaptedRadius, expectedRadius);
      });
    });
  });
}
