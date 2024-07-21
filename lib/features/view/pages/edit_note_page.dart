import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/core/res/app_color.dart';
import 'package:notes_app/core/res/app_string.dart';
import 'package:notes_app/core/res/app_style.dart';
import 'package:notes_app/features/view/provider/immutabel_data.dart';

class EditNotePage extends ConsumerStatefulWidget {
  final int id;

  EditNotePage({Key? key, required this.id}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends ConsumerState<EditNotePage> {
  late final TextEditingController title;
  late final TextEditingController body;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    body = TextEditingController();
    _loadNote();
  }

  Future<void> _loadNote() async {
    final note = await ref.read(noteByIdProvider(widget.id));
    if (note != null) {
      title.text = note['title'] ?? '';
      body.text = note['body'] ?? '';
    }
  }

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                if (title.text.isEmpty || body.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please Enter Your note to save"),
                    ),
                  );
                } else {
                  final result = await ref.read(editnoteProvider).update(
                      widget.id, {'title': title.text, 'body': body.text});
                  if (result == true) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('There is no connection')),
                    );
                  }
                }
              },
              child: Icon(
                Icons.save,
                color: white,
              ),
            ),
          )
        ],
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: TextField(
              controller: title,
              style: titleStyle,
              decoration: InputDecoration(
                fillColor: primaryColor,
                filled: true,
                border: InputBorder.none,
                hintText: TITLE,
                hintStyle: titleHintStyle,
              ),
            ),
          ),
          TextField(
            controller: body,
            style: bodyStyle,
            decoration: InputDecoration(
              fillColor: primaryColor,
              filled: true,
              border: InputBorder.none,
              hintText: TYPE,
              hintStyle: bodyHintStyle,
            ),
          ),
        ],
      ),
    );
  }
}
