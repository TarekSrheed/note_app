import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/data/service/edit_note_service.dart';
import 'package:notes_app/features/data/service/login_service.dart';
import 'package:notes_app/features/data/service/note_service.dart';

import 'package:supabase_flutter/supabase_flutter.dart';



final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

final noteDeletionProvider = Provider((ref) {
  final supabase = ref.watch(supabaseClientProvider);

  return (int id) async {
    final response =
        await supabase.from('notes').delete().eq('id', id).maybeSingle();
    if (response != null) {
      throw Exception('Error deleting note');
    }
  };
});

final noteEditProvider = Provider((ref) {
  final supabase = ref.watch(supabaseClientProvider);

  return (int id) async {
    final response =
        await supabase.from('notes').select().eq('id', id).maybeSingle();
    if (response != null) {
      throw Exception('Error Editing note');
    }
  };
});

final addToUserProvider = Provider<AddToUserService>((ref) {
  final supabaseClient = Supabase.instance.client;
  return AddToUserService(supabaseClient);
});

final addToNotesProvider = Provider<AddToNotesService>((ref) {
  final supabaseClient = Supabase.instance.client;
  return AddToNotesService(supabaseClient);
});

final editnoteProvider = Provider((ref) {
  final supabase = ref.watch(supabaseClientProvider);

  return EditNoteService(supabase);
});

final noteByIdProvider = Provider.autoDispose
    .family<Future<Map<String, dynamic>?>, int>((ref, id) async {
  final supabase = ref.watch(supabaseClientProvider);

  final response = await supabase.from('notes').select().eq('id', id).single();
  return response;
});
