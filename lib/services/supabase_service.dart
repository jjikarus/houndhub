import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://mghetpbljqqsadonypab.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IKpXVCJ9.eyJpc3MiOiJzdXf',
    );
  }
  
  static SupabaseClient get client => Supabase.instance.client;
}