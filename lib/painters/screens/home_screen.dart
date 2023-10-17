import 'package:flowd/painters/screens/flow_paint_region.dart';
import 'package:flowd/providers/paint_provider.dart';
import 'package:flowd/utils/enumns.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<PaintProvider>(builder: (context, paintProvider, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Selected Paint Mode ${paintModeData[paintProvider.paintMode]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Card(
                    color: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: PaintMode.values
                            .map(
                              (paintMode) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    paintProvider.setPaintMode = paintMode;
                                  },
                                  child: Chip(
                                    backgroundColor:
                                        paintMode == paintProvider.paintMode
                                            ? Colors.blue
                                            : Colors.white,
                                    label: Text(
                                      paintModeData[paintMode] ?? "",
                                      style: TextStyle(
                                          color: paintMode !=
                                                  paintProvider.paintMode
                                              ? Colors.blue
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: height * 0.8,
              width: width * 0.8,
              color: Colors.grey.shade800,
              child: const FlowPaintRegion(),
            )
          ],
        );
      }),
    );
  }
}
