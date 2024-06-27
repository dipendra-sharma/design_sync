import 'package:flutter/material.dart';
import 'package:design_sync/design_sync.dart';

void main() {
  // Initialize DesignSync with Figma canvas size
  DesignSync.initialize(
      figmaCanvasSize: const Size(375, 812)); // Example: iPhone X dimensions
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DesignSync Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access DesignSync instance
    final pp = DesignSync.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('DesignSync Demo',
            style: TextStyle(fontSize: 20.adaptedFontSize)),
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
                  style: TextStyle(
                      fontSize: 16.adaptedFontSize, color: Colors.white),
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
