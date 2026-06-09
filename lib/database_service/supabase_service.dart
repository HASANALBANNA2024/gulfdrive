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
      // ১. আগের সব ডেটা ডিলিট করা (টেবিল রিলেশন অনুযায়ী সিকোয়েন্স মেইনটেইন করা হয়েছে)
      await _supabase.from('packages').delete().neq('car_id', 0);
      await _supabase.from('cars').delete().neq('id', 0);
      await _supabase.from('car_categories').delete().neq('car_id', 0);
      await _supabase.from('categories').delete().neq('id', 0);

      // ২. Categories ইনসার্ট করা
      await _supabase.from('categories').insert([
        {'id': 1, 'name': 'Luxury'},
        {'id': 2, 'name': 'Budget'},
        {'id': 3, 'name': 'SUV'},
        {'id': 4, 'name': 'Sport'},
        {'id': 5, 'name': 'Sedan'},
      ]);

      // ৩. Cars ইনসার্ট করা (সবগুলো কলামসহ ৮টি ডেটা)
      await _supabase.from('cars').insert([
        {
          'id': 1,
          'name': 'BMW X5',
          'brand': 'BMW',
          'category': 'Luxury',
          'description': 'A premium luxury SUV with top-tier performance.',
          'engine_type': 'Electric and hybrid',
          'transmission': 'Automatic',
          'fuel_type': 'Petrol (Gasoline)',
          'seats': 12,
          'ac_status': true,
          'image_url':
              'https://images.unsplash.com/photo-1599914605927-4a0077c05001?q=80&w=600',
          'is_available': true,
          'is_maintainance_status': 'available',
          'car_features': 'Active Safety, GPS navigation',
        },
        {
          'id': 2,
          'name': 'Toyota Corolla',
          'brand': 'Toyota',
          'category': 'Budget',
          'description':
              'Reliable and fuel-efficient, perfect for city driving.',
          'engine_type': 'Internal Combustion',
          'transmission': 'Manual',
          'fuel_type': 'Petrol (Gasoline)',
          'seats': 5,
          'ac_status': true,
          'image_url':
              'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?q=80&w=600',
          'is_available': true,
          'is_maintainance_status': 'available',
          'car_features': 'Airbags, Bluetooth',
        },
        {
          'id': 3,
          'name': 'Land Rover Defender',
          'brand': 'Land Rover',
          'category': 'SUV',
          'description': 'Best for off-road adventures.',
          'engine_type': 'Turbo Diesel',
          'transmission': 'Automatic',
          'fuel_type': 'Diesel',
          'seats': 7,
          'ac_status': true,
          'image_url':
              'https://images.unsplash.com/photo-1619767767097-9e4a3e2a7b88?q=80&w=600',
          'is_available': true,
          'is_maintainance_status': 'available',
          'car_features': '4WD, Hill Descent Control',
        },
        {
          'id': 4,
          'name': 'Porsche 911',
          'brand': 'Porsche',
          'category': 'Sport',
          'description': 'A classic sports car with incredible speed.',
          'engine_type': 'Flat-six',
          'transmission': 'Manual',
          'fuel_type': 'Petrol (Gasoline)',
          'seats': 2,
          'ac_status': true,
          'image_url':
              'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=600',
          'is_available': true,
          'is_maintainance_status': 'available',
          'car_features': 'Launch Control, Sport Mode',
        },
        {
          'id': 5,
          'name': 'Honda Civic',
          'brand': 'Honda',
          'category': 'Sedan',
          'description': 'Comfortable and stylish sedan for everyday use.',
          'engine_type': 'Inline-four',
          'transmission': 'Automatic',
          'fuel_type': 'Petrol (Gasoline)',
          'seats': 5,
          'ac_status': true,
          'image_url':
              'https://images.unsplash.com/photo-1606152421802-db87e8e5030e?q=80&w=600',
          'is_available': true,
          'is_maintainance_status': 'available',
          'car_features': 'Lane Assist, Adaptive Cruise Control',
        },
        {
          'id': 6,
          'name': 'Tesla Model 3',
          'brand': 'Tesla',
          'category': 'Luxury',
          'description': 'Advanced electric vehicle with autopilot technology.',
          'engine_type': 'Electric',
          'transmission': 'Automatic',
          'fuel_type': 'Electric',
          'seats': 5,
          'ac_status': true,
          'image_url':
              'https://images.unsplash.com/photo-1560958089-b8a1929cea89?q=80&w=600',
          'is_available': true,
          'is_maintainance_status': 'available',
          'car_features': 'Autopilot, Panoramic Glass Roof',
        },
        {
          'id': 7,
          'name': 'Ford Mustang',
          'brand': 'Ford',
          'category': 'Sport',
          'description':
              'An iconic American muscle car with powerful performance.',
          'engine_type': 'V8',
          'transmission': 'Manual',
          'fuel_type': 'Petrol (Gasoline)',
          'seats': 4,
          'ac_status': true,
          'image_url':
              'https://images.unsplash.com/photo-1584345604476-8aa5e50b9239?q=80&w=600',
          'is_available': true,
          'is_maintainance_status': 'available',
          'car_features': 'Track Apps, High-Performance Brakes',
        },
        {
          'id': 8,
          'name': 'Hyundai Tucson',
          'brand': 'Hyundai',
          'category': 'SUV',
          'description': 'A versatile SUV designed for comfort and safety.',
          'engine_type': 'Inline-four',
          'transmission': 'Automatic',
          'fuel_type': 'Petrol (Gasoline)',
          'seats': 5,
          'ac_status': true,
          'image_url':
              'https://images.unsplash.com/photo-1622359648325-103138382c44?q=80&w=600',
          'is_available': true,
          'is_maintainance_status': 'available',
          'car_features': 'Blind-Spot View Monitor, Wireless Charging',
        },
      ]);

      print("৮টি গাড়ি সফলভাবে Supabase-এ ইনসার্ট হয়েছে!");
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
