import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/core/res/app_color.dart';
import 'package:notes_app/core/res/app_images.dart';
import 'package:notes_app/core/res/app_string.dart';
import 'package:notes_app/core/res/app_style.dart';
import 'package:notes_app/features/view/pages/add_note_page.dart';
import 'package:notes_app/features/view/pages/edit_note_page.dart';
import 'package:notes_app/features/view/provider/immutabel_data.dart';
import 'package:notes_app/features/view/provider/useful_provider.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          NOTES,
          style: appbarTitleStyle,
        ),
      ),
      body: Consumer(builder: (context, ref, _) {
        return ref.watch(notesStreamProvider).when(data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Image.asset(
                homeImage,
                width: 300,
                height: 300,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  key: Key(data[index]['id'].toString()),
                  onDismissed: (direction) async {
                    try {
                      await ref.read(noteDeletionProvider)(data[index]['id']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Note deleted')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error deleting note: $e')),
                      );
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditNotePage(
                            id: data[index]['id'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        data[index]['title'],
                        style: titleHomeStyle,
                      ),
                    ),
                  ),
                );
              }),
            );
          }
          // final snapshot = ref.read(notes);
        }, error: (error, stackTrace) {
          return const Text("there is an error");
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        });
      }),
      floatingActionButton: Consumer(builder: (context, ref, _) {
        return FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: primaryColor,
            elevation: 10,
            child: Icon(
              Icons.add,
              color: white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNote(),
                ),
              );
            });
      }),
    );
  }
}
