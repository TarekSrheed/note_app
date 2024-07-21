import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/features/view/provider/immutabel_data.dart';
import 'mokes_test.mocks.dart';
import 'package:postgrest/src/postgrest_builder.dart';
import 'package:postgrest/src/types.dart';


void main() {
  late MockSupabaseClient mockSupabaseClient;
  late ProviderContainer container;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    container = ProviderContainer(
      overrides: [
        supabaseClientProvider.overrideWithValue(mockSupabaseClient),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('noteDeletionProvider deletes note successfully', () async {
    final noteId = 1;

    when(mockSupabaseClient.from('notes').delete().eq('id', noteId).maybeSingle())
        .thenAnswer((_)  => null); // Mock successful deletion

    await container.read(noteDeletionProvider);
    verify(mockSupabaseClient.from('notes').delete().eq('id', noteId).maybeSingle()).called(1);
  });

  test('noteEditProvider retrieves note by ID', () async {
    final noteId = 1;
    PostgrestTransformBuilder<Map<String, dynamic>?> noteData = {'title': 'Test Note', 'body': 'This is a test note'} as PostgrestTransformBuilder<Map<String, dynamic>?>;

    when(mockSupabaseClient.from('notes').select().eq('id', noteId).maybeSingle())
        .thenAnswer((_)   => noteData);

    final note = await container.read(noteEditProvider);
    expect(note, equals(noteData));
  });
}
