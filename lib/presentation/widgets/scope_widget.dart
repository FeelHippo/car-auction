import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carbids/injector.dart';

class ScopeWidget extends StatelessWidget {

  final Widget child;
  final IOC scope;

  const ScopeWidget({Key? key, required this.child, required this.scope}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<IOC>(
        key: key,
        create: (context) => scope,
        dispose: (context, value) => value.dispose(),
        child: child ?? Container()
    );
  }
}