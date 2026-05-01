import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BindingScope extends StatefulWidget {
  const BindingScope({super.key, required this.binding, required this.child});

  final Bindings binding;
  final Widget child;

  @override
  State<BindingScope> createState() => _BindingScopeState();
}

class _BindingScopeState extends State<BindingScope> {
  @override
  void initState() {
    super.initState();
    widget.binding.dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
