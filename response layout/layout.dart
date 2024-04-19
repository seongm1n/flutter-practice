import 'package:flutter/material.dart';
import 'package:widget_example/responsive/responsive_center.dart';
import 'package:widget_example/responsive/breakpoint.dart';
import 'package:widget_example/signin.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Center responsive'),
      ),
      body: ResponsiveCenter(
        child: SignIn(),
        maxContentWidth: BreakPoint.tablet,
        padding: const EdgeInsets.all(16),),
    );
  }
}