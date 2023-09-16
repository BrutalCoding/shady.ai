import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DragAndDropWidget extends HookConsumerWidget {
  const DragAndDropWidget({super.key, required this.onDrop});

  final void Function(String pathToShadyAI) onDrop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mouseEntered = useState(false);
    final xFileOfAiModel = useState<XFile?>(null);
    return DropTarget(
      onDragDone: (detail) async {
        xFileOfAiModel.value = detail.files.first;
        onDrop(xFileOfAiModel.value!.path);
      },
      onDragEntered: (details) {
        mouseEntered.value = true;
      },
      onDragExited: (details) {
        mouseEntered.value = false;
      },
      child: Container(
        height: 150,
        width: 400,
        decoration: BoxDecoration(
          color: mouseEntered.value
              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
              : Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Icon(
            Icons.upload_file,
            color: Theme.of(context).colorScheme.secondary,
            size: 40,
          ),
        ),
      ),
    );
  }
}
