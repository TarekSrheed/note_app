import 'package:supabase_flutter/supabase_flutter.dart';

class AddToNotesService {
  final SupabaseClient client;

  AddToNotesService(this.client);

  Future<bool> insert(Map<String, String> note) async {
    try {
      final response = await client.from("notes").insert(note);
      if (response == null) {
        return true;
      } else {
        print('Error inserting note: $response');
        return false;
      }
    } catch (e) {
      print('Exception inserting note: $e');
      return false;
    }
  }
}
