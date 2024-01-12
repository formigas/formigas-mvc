import 'package:flutter/material.dart';
import 'package:formigas_mvc/formigas_mvc.dart';
import 'package:formigas_mvc_example/src/mvc_example_controller.dart';
import 'package:formigas_mvc_example/src/mvc_example_model.dart';

/// Stateful MVC Widget
class StatefulMViewCExample extends StatefulWidget {
  const StatefulMViewCExample({
    required this.controller,
    super.key,
  });

  final ExampleController controller;

  @override
  State<StatefulMViewCExample> createState() => _StatefulMViewCExampleState();
}

class _StatefulMViewCExampleState extends State<StatefulMViewCExample>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('MVCBuilderExample')),
      body: MVCBuilder<ExampleController, ExampleModel>(
        controller: widget.controller,
        builder: (context, controller, model) {
          debugPrint('_textController.text: ${_textController.text}');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Counter: ${model.value}'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a value',
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: MVCBuilder<ExampleController, ExampleModel>(
        controller: widget.controller,
        builder: (context, controller, model) => FloatingActionButton(
          onPressed: controller.increaseAndShuffleColor,
          backgroundColor: model.color,
          child: const Icon(Icons.plus_one),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
