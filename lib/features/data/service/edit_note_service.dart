import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteService {
  final SupabaseClient client;

  EditNoteService(this.client);

  Future<bool> update(int id, Map<String, dynamic> note) async {
    try {
      final response = await client.from('notes').update(note).eq('id', id);

      if (response != null) {
        print('Error updating note: $response');
        return false;
      }
      return true;
    } catch (e) {
      print('Exception updating note: $e');
      return false;
    }
  }
}
