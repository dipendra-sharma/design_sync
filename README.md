# DesignSync

DesignSync is a Flutter utility for creating pixel-perfect, responsive layouts by adapting dimensions from Figma designs to various device screen sizes.

## Features

- Adapt width and height dimensions from Figma to device screen
- Adapt font sizes from Figma to device screen, accounting for the device's text scale factor
- Adapt radius values (for rounded corners, etc.) from Figma to device screen
- Easy-to-use extension methods for numeric values
- No context required for adaptation operations
- Singleton pattern for efficient global access

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  design_sync: ^1.0.0
```

Then run:

```
flutter pub get
```

## Usage

1. Import DesignSync in your Dart file:

```dart
import 'package:design_sync/design_sync.dart';
```

2. Initialize DesignSync in your `main.dart` file before `runApp()`:

```dart
void main() {
  DesignSync.initialize(figmaCanvasSize: Size(375, 812)); // Use your Figma canvas size
  runApp(MyApp());
}
```

3. Use the adaptation methods or extension getters in your widget builds:

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DesignSync Demo', style: TextStyle(fontSize: 20.adaptedFontSize)),
      ),
      body: Center(
        child: Container(
          width: 200.adaptedWidth,
          height: 100.adaptedHeight,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.adaptedRadius),
          ),
          child: Center(
            child: Text(
              'Adapted Container',
              style: TextStyle(fontSize: 16.adaptedFontSize, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
```

## API Reference

### DesignSync Class

- `DesignSync.initialize({required Size figmaCanvasSize})`: Initialize DesignSync with your Figma canvas size.
- `DesignSync.instance`: Access the singleton instance of DesignSync.

#### Methods

- `adaptWidth(double figmaWidth)`: Adapt a width dimension from Figma.
- `adaptHeight(double figmaHeight)`: Adapt a height dimension from Figma.
- `adaptFontSize(double figmaFontSize)`: Adapt a font size from Figma.
- `adaptRadius(double figmaRadius)`: Adapt a radius value from Figma.

#### Properties

- `screenSize`: Get the current device screen size.
- `figmaCanvasSize`: Get the Figma canvas size used for adaptations.
- `widthFactor`: Get the current width adaptation factor.
- `heightFactor`: Get the current height adaptation factor.
- `textScaleFactor`: Get the current text scale factor of the device.

### Extension Methods

- `num.adaptedWidth`: Adapt a width value from Figma.
- `num.adaptedHeight`: Adapt a height value from Figma.
- `num.adaptedFontSize`: Adapt a font size value from Figma.
- `num.adaptedRadius`: Adapt a radius value from Figma.

## Example

Here's a more comprehensive example demonstrating various uses of DesignSync:

```dart
import 'package:flutter/material.dart';
import 'package:design_sync/design_sync.dart';

void main() {
  DesignSync.initialize(figmaCanvasSize: Size(375, 812)); // Example: iPhone X dimensions
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DesignSync Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pp = DesignSync.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('DesignSync Demo', style: TextStyle(fontSize: 20.adaptedFontSize)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200.adaptedWidth,
              height: 100.adaptedHeight,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.adaptedRadius),
              ),
              child: Center(
                child: Text(
                  'Adapted Container',
                  style: TextStyle(fontSize: 16.adaptedFontSize, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.adaptedHeight),
            Text(
              'Screen Size: ${pp.screenSize.width.toStringAsFixed(2)} x ${pp.screenSize.height.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14.adaptedFontSize),
            ),
            Text(
              'Figma Canvas Size: ${pp.figmaCanvasSize.width} x ${pp.figmaCanvasSize.height}',
              style: TextStyle(fontSize: 14.adaptedFontSize),
            ),
            Text(
              'Width Factor: ${pp.widthFactor.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14.adaptedFontSize),
            ),
            Text(
              'Height Factor: ${pp.heightFactor.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14.adaptedFontSize),
            ),
            Text(
              'Text Scale Factor: ${pp.textScaleFactor.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14.adaptedFontSize),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.