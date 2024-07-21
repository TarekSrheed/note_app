import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/features/data/service/edit_note_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:notes_app/features/data/service/note_service.dart';

import 'mokes_test.mocks.dart'; 

// Generate mock classes
@GenerateMocks([SupabaseClient])
void main() {
  late MockSupabaseClient mockSupabaseClient;
  late AddToNotesService addToNotesService;
  late EditNoteService editNoteService;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    addToNotesService = AddToNotesService(mockSupabaseClient);
    editNoteService = EditNoteService(mockSupabaseClient);
  });

  test('AddToNotesService inserts note successfully', () async {
    final noteData = {'title': 'Test Note', 'body': 'This is a test note'};

    when(mockSupabaseClient.from('notes').insert(noteData))
        .thenAnswer((_)  => null); // Mock successful insertion

    final result = await addToNotesService.insert(noteData);
    expect(result, isTrue);
  });

  test('AddToNotesService handles insertion error', () async {
    final noteData = {'title': 'Test Note', 'body': 'This is a test note'};

    when(mockSupabaseClient.from('notes').insert(noteData))
        .thenThrow(Exception('Error inserting note'));

    final result = await addToNotesService.insert(noteData);
    expect(result, isFalse);
  });

  test('EditNoteService updates note successfully', () async {
    final noteId = 1;
    final noteData = {'title': 'Updated Note', 'body': 'Updated body'};

    when(mockSupabaseClient.from('notes').update(noteData).eq('id', noteId))
        .thenAnswer((_)  => null); // Mock successful update

    final result = await editNoteService.update(noteId, noteData);
    expect(result, isTrue);
  });

  test('EditNoteService handles update error', () async {
    final noteId = 1;
    final noteData = {'title': 'Updated Note', 'body': 'Updated body'};

    when(mockSupabaseClient.from('notes').update(noteData).eq('id', noteId))
        .thenThrow(Exception('Error updating note'));

    final result = await editNoteService.update(noteId, noteData);
    expect(result, isFalse);
  });
}
