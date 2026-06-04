import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;

  /// any table data fetch
  Future<List<Map<String, dynamic>>> fetchData(String tableName) async {
    return await _supabase.from(tableName).select('*');
  }

  /// any table data insert
  Future<void> insertData(String tableName, Map<String, dynamic> data) async {
    await _supabase.from(tableName).insert(data);
  }

  /// any table data update
  Future<void> updateData(
    String tableName,
    int id,
    Map<String, dynamic> data,
  ) async {
    await _supabase.from(tableName).update(data).eq('id', id);
  }

  /// any table data delete
  Future<void> deleteData(String tableName, int id) async {
    await _supabase.from(tableName).delete().eq('id', id);
  }

  /// car delete with images
  Future<void> deleteCarWithImage(
    int carId,
    String bucketName,
    String imagePath,
  ) async {
    try {
      await _supabase.storage.from(bucketName).remove([imagePath]);
      await _supabase.from('cars').delete().eq('id', carId);

      debugPrint("Successfully image with data delete!");
    } catch (e) {
      debugPrint("problem is issued for delete and update: $e");
    }
  }

  /// dummy data

  Future<void> seedDatabase() async {
    try {
      // ১. আগের ডেটা ডিলিট করা
      await _supabase.from('car_categories').delete().neq('car_id', 0);
      await _supabase.from('packages').delete().neq('car_id', 0);
      await _supabase.from('cars').delete().neq('id', 0);
      await _supabase.from('categories').delete().neq('id', 0);

      // ২. নতুন ডেটা ইনসার্ট করা (সাথে Real Network Image)
      await _supabase.from('categories').insert([
        {'id': 1, 'name': 'Luxury'},
        {'id': 2, 'name': 'Budget'},
      ]);

      await _supabase.from('cars').insert([
        {
          'id': 1,
          'name': 'BMW X5',
          'brand': 'BMW',
          'category': 'Luxury',
          'base_price': 500.0,
          // এখানে রিয়েল ইমেজ লিংক ব্যবহার করা হয়েছে
          'image_url':
              'https://images.unsplash.com/photo-1599914605927-4a0077c05001?q=80&w=600&auto=format&fit=crop',
        },
        {
          'id': 2,
          'name': 'Toyota Corolla',
          'brand': 'Toyota',
          'category': 'Budget',
          'base_price': 100.0,
          'image_url':
              'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?q=80&w=600&auto=format&fit=crop',
        },
      ]);

      // বাকি ইনসার্ট কোড...
      print("সব ডেটা সফলভাবে রিয়েল ইমেজসহ ইনসার্ট হয়েছে!");
    } catch (e) {
      print("Error: $e");
    }
  }

  /// all data fetch then splash screen remove
  Future<Map<String, dynamic>> initializeAllData() async {
    try {
      /// table fetch
      final carsResponse = await _supabase.from('cars').select('*');
      final packageResponse = await _supabase.from('packages').select('*');
      final categoriesResponse = await _supabase.from('categories').select('*');
      final car_Categoriesresponse = await _supabase
          .from('car_categories')
          .select('*');

      return {
        'cars': carsResponse,
        'packages': packageResponse,
        'categories': categoriesResponse,
        'car_categories': car_Categoriesresponse,
        // 'categories': categoriesResponse,
      };
    } catch (e) {
      throw Exception('ডাটাবেস লোড করতে সমস্যা হয়েছে: $e');
    }
  }
}
