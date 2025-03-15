import 'package:fs_currier/global/models/country_model.dart';
import 'package:fs_currier/global/repository/global_repo.dart';
import 'package:get/get.dart';

import '../models/county_model.dart';
import '../models/f_s_spot_model.dart';
import '../models/sub_zone_model.dart';
import '../models/zone_model.dart';

class GlobalsController extends GetxController {
  final GlobalRepo _globalRepo = GlobalRepo();

  // Common variables for countries
  var countries = <Country>[].obs;
  var isLoadingCountries = false.obs;
  var countryErrorMessage = ''.obs;

  @override
  void onInit() {
    fetchCountries();
    super.onInit();
  }

  // Fetch all countries (common for both pickup and dropoff)
  void fetchCountries() async {
    try {
      isLoadingCountries(true);
      final CountryModel countryModel = await _globalRepo.getCountries();
      if (countryModel.success == true) {
        countries.assignAll(countryModel.data!);
      } else {
        countryErrorMessage.value = countryModel.message ?? 'Failed to load countries';
      }
    } catch (e) {
      countryErrorMessage.value = 'Failed to load countries: $e';
    } finally {
      isLoadingCountries(false);
    }
  }

  // Pickup Location Variables
  var pickupCounties = <County>[].obs;
  var isLoadingPickupCounties = false.obs;
  var pickupCountyErrorMessage = ''.obs;

  var pickupZones = <Zone>[].obs;
  var isLoadingPickupZones = false.obs;
  var pickupZoneErrorMessage = ''.obs;

  var pickupSubZones = <SubZone>[].obs;
  var isLoadingPickupSubZones = false.obs;
  var pickupSubZoneErrorMessage = ''.obs;

  var pickupFSSpots = <Data>[].obs;
  var isLoadingPickupFSSpots = false.obs;
  var pickupFSSpotErrorMessage = ''.obs;

  var selectedPickupCountryId = 0.obs;
  var selectedPickupCountyId = 0.obs;
  var selectedPickupZoneId = 0.obs;
  var selectedPickupSubZoneId = 0.obs;
  var selectedPickupFSSpotId = 0.obs;

  // Dropoff Location Variables
  var dropoffCounties = <County>[].obs;
  var isLoadingDropoffCounties = false.obs;
  var dropoffCountyErrorMessage = ''.obs;

  var dropoffZones = <Zone>[].obs;
  var isLoadingDropoffZones = false.obs;
  var dropoffZoneErrorMessage = ''.obs;

  var dropoffSubZones = <SubZone>[].obs;
  var isLoadingDropoffSubZones = false.obs;
  var dropoffSubZoneErrorMessage = ''.obs;

  var dropoffFSSpots = <Data>[].obs;
  var isLoadingDropoffFSSpots = false.obs;
  var dropoffFSSpotErrorMessage = ''.obs;

  var selectedDropoffCountryId = 0.obs;
  var selectedDropoffCountyId = 0.obs;
  var selectedDropoffZoneId = 0.obs;
  var selectedDropoffSubZoneId = 0.obs;
  var selectedDropoffFSSpotId = 0.obs;

  // Fetch Pickup Counties by CountryId
  void fetchPickupCounties(int countryId) async {
    try {
      isLoadingPickupCounties(true);
      final CountyModel countyModel = await _globalRepo.getCounties(countryId);
      if (countyModel.success == true) {
        pickupCounties.assignAll(countyModel.data!);
      } else {
        pickupCountyErrorMessage.value = countyModel.message ?? 'Failed to load pickup counties';
      }
    } catch (e) {
      pickupCountyErrorMessage.value = 'Failed to load pickup counties: $e';
    } finally {
      isLoadingPickupCounties(false);
    }
  }

  // Fetch Dropoff Counties by CountryId
  void fetchDropoffCounties(int countryId) async {
    try {
      isLoadingDropoffCounties(true);
      final CountyModel countyModel = await _globalRepo.getCounties(countryId);
      if (countyModel.success == true) {
        dropoffCounties.assignAll(countyModel.data!);
      } else {
        dropoffCountyErrorMessage.value = countyModel.message ?? 'Failed to load dropoff counties';
      }
    } catch (e) {
      dropoffCountyErrorMessage.value = 'Failed to load dropoff counties: $e';
    } finally {
      isLoadingDropoffCounties(false);
    }
  }

  // Fetch Pickup Zones by CountyId
  void fetchPickupZones(int countyId) async {
    try {
      isLoadingPickupZones(true);
      final ZoneModel zoneModel = await _globalRepo.getZones(countyId);
      if (zoneModel.success == true) {
        pickupZones.value = zoneModel.data!;
      } else {
        pickupZoneErrorMessage.value = zoneModel.message ?? 'Failed to load pickup zones';
      }
    } catch (e) {
      pickupZoneErrorMessage.value = 'Failed to load pickup zones: $e';
    } finally {
      isLoadingPickupZones(false);
    }
  }

  // Fetch Dropoff Zones by CountyId
  void fetchDropoffZones(int countyId) async {
    try {
      isLoadingDropoffZones(true);
      final ZoneModel zoneModel = await _globalRepo.getZones(countyId);
      if (zoneModel.success == true) {
        dropoffZones.value = zoneModel.data!;
      } else {
        dropoffZoneErrorMessage.value = zoneModel.message ?? 'Failed to load dropoff zones';
      }
    } catch (e) {
      dropoffZoneErrorMessage.value = 'Failed to load dropoff zones: $e';
    } finally {
      isLoadingDropoffZones(false);
    }
  }

  // Fetch Pickup SubZones by ZoneId
  void fetchPickupSubZones(int zoneId) async {
    try {
      isLoadingPickupSubZones(true);
      final SubZoneModel subZoneModel = await _globalRepo.getSubZones(zoneId);
      if (subZoneModel.success == true) {
        pickupSubZones.value = subZoneModel.data!;
      } else {
        pickupSubZoneErrorMessage.value = subZoneModel.message ?? 'Failed to load pickup subzones';
      }
    } catch (e) {
      pickupSubZoneErrorMessage.value = 'Failed to load pickup subzones: $e';
    } finally {
      isLoadingPickupSubZones(false);
    }
  }

  // Fetch Dropoff SubZones by ZoneId
  void fetchDropoffSubZones(int zoneId) async {
    try {
      isLoadingDropoffSubZones(true);
      final SubZoneModel subZoneModel = await _globalRepo.getSubZones(zoneId);
      if (subZoneModel.success == true) {
        dropoffSubZones.value = subZoneModel.data!;
      } else {
        dropoffSubZoneErrorMessage.value = subZoneModel.message ?? 'Failed to load dropoff subzones';
      }
    } catch (e) {
      dropoffSubZoneErrorMessage.value = 'Failed to load dropoff subzones: $e';
    } finally {
      isLoadingDropoffSubZones(false);
    }
  }

  // Fetch Pickup FS-Spots by SubZoneId
  void fetchPickupFSSpots(int subZoneId) async {
    try {
      isLoadingPickupFSSpots(true);
      final FSSpotModel fsSpotModel = await _globalRepo.getFSSpots(subZoneId);
      if (fsSpotModel.success == true) {
        pickupFSSpots.value = fsSpotModel.data!;
      } else {
        pickupFSSpotErrorMessage.value = fsSpotModel.message ?? 'Failed to load pickup fs-spots';
      }
    } catch (e) {
      pickupFSSpotErrorMessage.value = 'Failed to load pickup fs-spots: $e';
    } finally {
      isLoadingPickupFSSpots(false);
    }
  }

  // Fetch Dropoff FS-Spots by SubZoneId
  void fetchDropoffFSSpots(int subZoneId) async {
    try {
      isLoadingDropoffFSSpots(true);
      final FSSpotModel fsSpotModel = await _globalRepo.getFSSpots(subZoneId);
      if (fsSpotModel.success == true) {
        dropoffFSSpots.value = fsSpotModel.data!;
      } else {
        dropoffFSSpotErrorMessage.value = fsSpotModel.message ?? 'Failed to load dropoff fs-spots';
      }
    } catch (e) {
      dropoffFSSpotErrorMessage.value = 'Failed to load dropoff fs-spots: $e';
    } finally {
      isLoadingDropoffFSSpots(false);
    }
  }
}
