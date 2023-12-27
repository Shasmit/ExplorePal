import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardView extends ConsumerStatefulWidget {
  const DashBoardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends ConsumerState<DashBoardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoardView'),
      ),
    );
  }
}
