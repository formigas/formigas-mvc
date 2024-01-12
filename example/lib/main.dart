import 'package:flutter/material.dart';
import 'package:formigas_mvc_example/src/mvc_example_controller.dart';
import 'package:formigas_mvc_example/src/mvc_example_view.dart';
import 'package:formigas_mvc_example/src/mvc_example_view1.dart';
import 'package:formigas_mvc_example/src/mvc_example_view2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: _PagerScreen());
}

class _PagerScreen extends StatelessWidget {
  const _PagerScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('formigas MVC example app'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: TabBar(
              tabs: [
                Tab(text: 'MViewC '),
                Tab(text: 'MVCBuilder'),
                Tab(text: 'StatefulMViewC'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ///Example using Stateless MViewC
            MViewCExample(controller: MvcExampleControllerImplementation()),

            ///Example using MVCBuilder
            MVCBuilderExample(controller: MvcExampleControllerImplementation()),

            ///Example using Stateful MVCWidget
            StatefulMViewCExample(
              controller: MvcExampleControllerImplementation(),
            ),
          ],
        ),
      ),
    );
  }
}
