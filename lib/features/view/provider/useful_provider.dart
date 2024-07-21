import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_app/features/view/provider/immutabel_data.dart';

final notesStreamProvider = StreamProvider((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final stream = supabase.from('notes').stream(primaryKey: ['id']);
  return stream;
});


