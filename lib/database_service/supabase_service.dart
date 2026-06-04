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

  // Future<void> seedDatabase() async {
  //   try {
  //     // ১. আগে সব ডেটা ক্লিয়ার করে দিন যাতে আইডি কনফ্লিক্ট না করে
  //     await _supabase.from('car_categories').delete().neq('car_id', 0);
  //     await _supabase.from('packages').delete().neq('car_id', 0);
  //     await _supabase.from('cars').delete().neq('id', 0);
  //     await _supabase.from('categories').delete().neq('id', 0);
  //
  //     // ২. এখন নতুন করে ইনসার্ট করুন
  //     await _supabase.from('categories').insert([
  //       {'id': 1, 'name': 'Luxury'},
  //       {'id': 2, 'name': 'Budget'},
  //     ]);
  //
  //     await _supabase.from('cars').insert([
  //       {
  //         'id': 1,
  //         'name': 'BMW X5',
  //         'brand': 'BMW',
  //         'category': 'Luxury',
  //         'base_price': 500.0,
  //         'image_url': 'cars/bmw_x5.jpg',
  //       },
  //       {
  //         'id': 2,
  //         'name': 'Toyota Corolla',
  //         'brand': 'Toyota',
  //         'category': 'Budget',
  //         'base_price': 100.0,
  //         'image_url': 'cars/toyota_corolla.jpg',
  //       },
  //     ]);
  //
  //     await _supabase.from('packages').insert([
  //       {'car_id': 1, 'package_name': 'Weekly Luxury', 'price': 3000.0},
  //       {'car_id': 2, 'package_name': 'Daily Budget', 'price': 90.0},
  //     ]);
  //
  //     await _supabase.from('car_categories').insert([
  //       {'car_id': 1, 'category_id': 1},
  //       {'car_id': 2, 'category_id': 2},
  //     ]);
  //
  //     print("সব ডেটা সফলভাবে রিসেট এবং ইনসার্ট হয়েছে!");
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

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
