import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final SystemUiOverlayStyle? systemUiOverlayStyleIOS;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomPadding;

  const AppScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.systemUiOverlayStyleIOS,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomPadding = true,
  }) : super(key: key);

  @override
  AppScaffoldState createState() => AppScaffoldState();

  static AppScaffoldState? of(BuildContext context, { bool nullOk = false }) {
    final AppScaffoldState? result = context.findAncestorStateOfType<AppScaffoldState>();
    if (nullOk || result != null) {
      return result;
    }
    throw 'AppScaffold.of() called with a context that does not contain a AppScaffold.';
  }
}

class AppScaffoldState extends State<AppScaffold> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          widget.body,
        ],
      ),
    );
  }
}