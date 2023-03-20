import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementtwo/provider/exampleprovider.dart';

class ExampleOne extends StatefulWidget {
  const ExampleOne({super.key});

  @override
  State<ExampleOne> createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne> {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(title: Text("Example one")),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<ExampleProvider>(builder: (context, value, child) {
              return Slider(
                  min: 0,
                  max: 1,
                  value: value.value,
                  onChanged: (val) {
                    value.setValue(val);
                  });
            }),
            Consumer<ExampleProvider>(builder: (context, value, child) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(value.value)),
                      child: Center(child: Text("container 1")),
                      height: 150,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 86, 40, 166)
                              .withOpacity(value.value)),
                      child: Center(child: Text("Container 2")),
                      height: 150,
                    ),
                  )
                ],
              );
            })
          ]),
    );
  }
}
