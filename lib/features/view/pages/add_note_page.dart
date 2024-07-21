import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/core/res/app_color.dart';
import 'package:notes_app/core/res/app_string.dart';
import 'package:notes_app/core/res/app_style.dart';
import 'package:notes_app/features/view/provider/immutabel_data.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();
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
            child: Consumer(builder: (context, ref, _) {
              return InkWell(
                onTap: () async {
                  if (title.text.isEmpty || body.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please Enter Your note to save"),
                      ),
                    );
                  } else {
                    final result = await ref
                        .read(addToNotesProvider)
                        .insert({'title': title.text, 'body': body.text});
                    if (result == true) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('there is no conection')),
                      );
                    }
                  }
                },
                child: Icon(
                  Icons.save,
                  color: white,
                ),
              );
            }),
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
                  hintStyle: titleHintStyle),
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
                hintStyle: bodyHintStyle),
          ),
        ],
      ),
    );
  }
}
