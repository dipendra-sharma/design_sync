import 'dart:ui';

/// A utility class for adapting Figma designs to various screen sizes in Flutter applications.
///
/// This class uses a singleton pattern to provide global access to adaptation methods.
/// It must be initialized with the Figma canvas size before use.
class DesignSync {
  /// The singleton instance of DesignSync.
  /// This is nullable and will be null until [initialize] is called.
  static DesignSync? _instance;

  /// The size of the Figma canvas used in the design.
  /// This is used as the reference for all adaptations.
  final Size _figmaCanvasSize;

  /// The actual size of the device screen.
  /// This is calculated when the class is initialized.
  late final Size _screenSize;

  /// The factor used to adapt widths from Figma to the device screen.
  /// Calculated as (screen width / Figma canvas width).
  late final double _widthFactor;

  /// The factor used to adapt heights from Figma to the device screen.
  /// Calculated as (screen height / Figma canvas height).
  late final double _heightFactor;

  /// The text scale factor of the device.
  /// This is used to adjust font sizes for the device's text scaling settings.
  late final double _textScaleFactor;

  /// Private constructor to enforce the singleton pattern.
  /// Initializes all late final variables.
  DesignSync._internal(this._figmaCanvasSize) {
    _updateScreenSize();
    _widthFactor = _screenSize.width / _figmaCanvasSize.width;
    _heightFactor = _screenSize.height / _figmaCanvasSize.height;
    _textScaleFactor = PlatformDispatcher.instance.textScaleFactor;
  }

  /// Updates the [_screenSize] based on the current device screen dimensions.
  void _updateScreenSize() {
    final FlutterView view = PlatformDispatcher.instance.views.first;
    _screenSize = view.physicalSize / view.devicePixelRatio;
  }

  /// Initializes the DesignSync singleton with the given Figma canvas size.
  ///
  /// This method must be called before any other DesignSync methods are used.
  ///
  /// [figmaCanvasSize]: The size of the Figma canvas used in the design.
  static void initialize({required Size figmaCanvasSize}) {
    _instance = DesignSync._internal(figmaCanvasSize);
  }

  /// Provides access to the DesignSync singleton instance.
  ///
  /// Throws a [StateError] if accessed before [initialize] is called.
  static DesignSync get instance {
    if (_instance == null) {
      throw StateError(
          'DesignSync has not been initialized. Call DesignSync.initialize() first.');
    }
    return _instance!;
  }

  /// Adapts a width dimension from Figma to the device screen.
  ///
  /// [figmaWidth]: The width dimension from the Figma design.
  ///
  /// Returns the adapted width for the current device screen.
  double adaptWidth(double figmaWidth) => figmaWidth * _widthFactor;

  /// Adapts a height dimension from Figma to the device screen.
  ///
  /// [figmaHeight]: The height dimension from the Figma design.
  ///
  /// Returns the adapted height for the current device screen.
  double adaptHeight(double figmaHeight) => figmaHeight * _heightFactor;

  /// Adapts a font size from Figma to the device screen.
  ///
  /// This method also takes into account the device's text scale factor.
  ///
  /// [figmaFontSize]: The font size from the Figma design.
  ///
  /// Returns the adapted font size for the current device screen.
  double adaptFontSize(double figmaFontSize) =>
      figmaFontSize * _widthFactor / _textScaleFactor;

  /// Adapts a radius (for corners, etc.) from Figma to the device screen.
  ///
  /// [figmaRadius]: The radius dimension from the Figma design.
  ///
  /// Returns the adapted radius for the current device screen.
  double adaptRadius(double figmaRadius) => figmaRadius * _widthFactor;

  /// The current device screen size.
  Size get screenSize => _screenSize;

  /// The Figma canvas size used for adaptations.
  Size get figmaCanvasSize => _figmaCanvasSize;

  /// The current width adaptation factor.
  double get widthFactor => _widthFactor;

  /// The current height adaptation factor.
  double get heightFactor => _heightFactor;

  /// The current text scale factor of the device.
  double get textScaleFactor => _textScaleFactor;
}

/// Extension methods for easy adaptation of numeric values.
extension DesignSyncExtension on num {
  /// Adapts a width value from Figma to the current device screen.
  double get adaptedWidth => DesignSync.instance.adaptWidth(toDouble());

  /// Adapts a height value from Figma to the current device screen.
  double get adaptedHeight => DesignSync.instance.adaptHeight(toDouble());

  /// Adapts a font size value from Figma to the current device screen.
  double get adaptedFontSize => DesignSync.instance.adaptFontSize(toDouble());

  /// Adapts a radius value from Figma to the current device screen.
  double get adaptedRadius => DesignSync.instance.adaptRadius(toDouble());
}
