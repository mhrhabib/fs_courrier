import '../../services/api_list.dart';
import '../../services/base_client.dart';
import '../models/country_model.dart';
import '../models/county_model.dart';
import '../models/f_s_spot_model.dart';
import '../models/sub_zone_model.dart';
import '../models/zone_model.dart';

class GlobalRepo {
  Future<CountryModel> getCountries() async {
    try {
      final response = await BaseClient.get(url: APIList.countriesUrl);
      return CountryModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }

  // New method to fetch counties by countryId
  Future<CountyModel> getCounties(int countryId) async {
    try {
      final response = await BaseClient.get(
        url: APIList.countyUrl,
        payload: {'country_id': countryId}, // Pass countryId as a query parameter
      );
      return CountyModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load counties: $e');
    }
  }

  // Fetch zones by countyId
  Future<ZoneModel> getZones(int countyId) async {
    try {
      final response = await BaseClient.get(
        url: APIList.zoneUrl,
        payload: {'county_id': countyId}, // Pass countyId as a query parameter
      );
      return ZoneModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load zones: $e');
    }
  }

  // Fetch subzones by zoneId
  Future<SubZoneModel> getSubZones(int zoneId) async {
    try {
      final response = await BaseClient.get(
        url: APIList.subZoneUrl,
        payload: {'zone_id': zoneId}, // Pass zoneId as a query parameter
      );
      return SubZoneModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load subzones: $e');
    }
  }

  // Fetch fs-spots by subZoneId
  Future<FSSpotModel> getFSSpots(int subZoneId) async {
    try {
      final response = await BaseClient.get(
        url: APIList.fsSpotlistUrl,
        payload: {'sub_zone_id': subZoneId}, // Pass subZoneId as a query parameter
      );
      return FSSpotModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load fs-spots: $e');
    }
  }
}
