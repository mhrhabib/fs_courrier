import 'package:flutter/material.dart';
import 'package:fs_currier/Controllers/parcel_controller.dart';
import 'package:get/get.dart';
import '../../global/controllers/global_controller.dart';
import '../Widgets/custom_dropdown.dart';
import '../Widgets/dropdown_with_search.dart';

class FromLocationSearch extends StatefulWidget {
  final GlobalsController controller;
  final ParcelController parcelController;

  const FromLocationSearch({required this.parcelController, required this.controller, super.key});

  @override
  State<FromLocationSearch> createState() => _FromLocationSearchState();
}

class _FromLocationSearchState extends State<FromLocationSearch> {
  String? selectedCountry;
  String? selectedCounty;
  String? selectedZone;
  String? selectedSubZone;
  String? selectedFS;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Country Dropdown
        Obx(() {
          if (widget.controller.isLoadingCountries.value) {
            return Center(child: CircularProgressIndicator());
          }
          return DropdownWithSearch<String>(
            value: selectedCountry,
            items: widget.controller.countries.map((country) => country.name!).toList(),
            onChanged: (value) {
              var country = widget.controller.countries.firstWhere((e) => e.name == value);
              widget.controller.selectedPickupCountryId.value = country.id!;
              widget.parcelController.selectedCountryId.value = country.id!;
              widget.controller.fetchPickupCounties(country.id!); // Fetch pickup counties
              widget.controller.selectedPickupCountyId.value = 0; // Reset pickup county selection
              widget.controller.selectedPickupZoneId.value = 0; // Reset pickup zone selection
              widget.controller.selectedPickupSubZoneId.value = 0; // Reset pickup subzone selection
              widget.controller.selectedPickupFSSpotId.value = 0; // Reset pickup fs-spot selection
            },
            labelText: 'Select Country',
            hintText: 'country',
          );
        }),
        Obx(
          () => (widget.controller.selectedPickupCountryId.value != 0 && widget.controller.pickupCounties.isNotEmpty) ? SizedBox(height: 16) : SizedBox.shrink(),
        ),

        // County Dropdown (visible only if counties are loaded)
        Obx(() {
          if (widget.controller.isLoadingPickupCounties.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.controller.selectedPickupCountryId.value != 0) {
            if (widget.controller.pickupCounties.isEmpty) {
              return Text("No counties available");
            }
            return CustomDropdown<String>(
              value: selectedCounty,
              items: widget.controller.pickupCounties.map((county) => county.name!).toList(),
              onChanged: (value) {
                var county = widget.controller.pickupCounties.firstWhere((e) => e.name == value);
                widget.controller.selectedPickupCountyId.value = county.id!;
                widget.parcelController.selectedCountyId.value = county.id!;
                widget.controller.fetchPickupZones(county.id!); // Fetch pickup zones
                widget.controller.selectedPickupZoneId.value = 0; // Reset pickup zone selection
                widget.controller.selectedPickupSubZoneId.value = 0; // Reset pickup subzone selection
                widget.controller.selectedPickupFSSpotId.value = 0; // Reset pickup fs-spot selection
              },
              labelText: 'Select County',
              hintText: 'county',
            );
          } else {
            return SizedBox.shrink(); // Hide if no counties are loaded
          }
        }),
        Obx(
          () => (widget.controller.selectedPickupCountyId.value != 0 && widget.controller.pickupZones.isNotEmpty) ? SizedBox(height: 16) : SizedBox.shrink(),
        ),

        // Zone Dropdown (visible only if zones are loaded)
        Obx(() {
          if (widget.controller.isLoadingPickupZones.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.controller.selectedPickupCountyId.value != 0) {
            if (widget.controller.pickupZones.isEmpty) {
              return Text("No zones available");
            }
            return CustomDropdown<String>(
              value: selectedZone,
              items: widget.controller.pickupZones.map((zone) => zone.name!).toList(),
              onChanged: (value) {
                var zone = widget.controller.pickupZones.firstWhere((zone) => zone.name == value);
                widget.controller.selectedPickupZoneId.value = zone.id!;
                widget.parcelController.selectedZoneId.value = zone.id!;
                widget.controller.fetchPickupSubZones(zone.id!); // Fetch pickup subzones
                widget.controller.selectedPickupSubZoneId.value = 0; // Reset pickup subzone selection
                widget.controller.selectedPickupFSSpotId.value = 0; // Reset pickup fs-spot selection
              },
              labelText: 'Select Zone',
              hintText: 'zone',
            );
          } else {
            return SizedBox.shrink(); // Hide if no zones are loaded
          }
        }),
        Obx(
          () => (widget.controller.selectedPickupZoneId.value != 0 && widget.controller.pickupSubZones.isNotEmpty) ? SizedBox(height: 16) : SizedBox.shrink(),
        ),

        // SubZone Dropdown (visible only if subzones are loaded)
        Obx(() {
          if (widget.controller.isLoadingPickupSubZones.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.controller.selectedPickupZoneId.value != 0) {
            if (widget.controller.pickupSubZones.isEmpty) {
              return Text("No subzones available");
            }
            return CustomDropdown<String>(
              value: selectedSubZone,
              items: widget.controller.pickupSubZones.map((subZone) => subZone.name!).toList(),
              onChanged: (value) {
                var subzone = widget.controller.pickupSubZones.firstWhere((e) => e.name == value);
                widget.controller.selectedPickupSubZoneId.value = subzone.id!;
                widget.parcelController.selectedSubZoneId.value = subzone.id!;
                widget.controller.fetchPickupFSSpots(subzone.id!); // Fetch pickup fs-spots
                widget.controller.selectedPickupFSSpotId.value = 0; // Reset pickup fs-spot selection
              },
              labelText: 'Select SubZone',
              hintText: 'sub-zone',
            );
          } else {
            return SizedBox.shrink(); // Hide if no subzones are loaded
          }
        }),
        Obx(
          () => (widget.controller.selectedPickupSubZoneId.value != 0 && widget.controller.pickupFSSpots.isNotEmpty) ? SizedBox(height: 16) : SizedBox.shrink(),
        ),

        // FSSpot Dropdown (visible only if fs-spots are loaded)
        Obx(() {
          if (widget.controller.isLoadingPickupFSSpots.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.controller.selectedPickupSubZoneId.value != 0) {
            if (widget.controller.pickupFSSpots.isEmpty) {
              return Text("No fs-spots available");
            }
            return CustomDropdown<String>(
              value: selectedFS,
              items: widget.controller.pickupFSSpots.map((fsSpot) => fsSpot.name!).toList(),
              onChanged: (value) {
                var fs = widget.controller.pickupFSSpots.firstWhere((e) => e.name == value);
                widget.controller.selectedPickupFSSpotId.value = fs.id!;
                widget.parcelController.selectedFSSpotId.value = fs.id!;
              },
              labelText: 'Select FSSpot',
              hintText: 'fs-spot',
            );
          } else {
            return SizedBox.shrink(); // Hide if no fs-spots are loaded
          }
        }),
      ],
    );
  }
}

class ToLocationSearch extends StatefulWidget {
  final GlobalsController controller;
  final ParcelController parcelController;

  const ToLocationSearch({required this.parcelController, required this.controller, super.key});

  @override
  State<ToLocationSearch> createState() => _ToLocationSearchState();
}

class _ToLocationSearchState extends State<ToLocationSearch> {
  String? selectedCountry;
  String? selectedCounty;
  String? selectedZone;
  String? selectedSubZone;
  String? selectedFS;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Country Dropdown
        Obx(() {
          if (widget.controller.isLoadingCountries.value) {
            return Center(child: CircularProgressIndicator());
          }
          return DropdownWithSearch<String>(
            value: selectedCountry,
            items: widget.controller.countries.map((country) => country.name!).toList(),
            onChanged: (value) {
              var country = widget.controller.countries.firstWhere((e) => e.name == value);
              widget.controller.selectedDropoffCountryId.value = country.id!;
              widget.parcelController.toSelectedCountryId.value = country.id!;
              widget.controller.fetchDropoffCounties(country.id!); // Fetch dropoff counties
              widget.controller.selectedDropoffCountyId.value = 0; // Reset dropoff county selection
              widget.controller.selectedDropoffZoneId.value = 0; // Reset dropoff zone selection
              widget.controller.selectedDropoffSubZoneId.value = 0; // Reset dropoff subzone selection
              widget.controller.selectedDropoffFSSpotId.value = 0; // Reset dropoff fs-spot selection
            },
            labelText: 'Select Country',
            hintText: 'country',
          );
        }),
        Obx(
          () => (widget.controller.selectedDropoffCountryId.value != 0 && widget.controller.dropoffCounties.isNotEmpty) ? SizedBox(height: 16) : SizedBox.shrink(),
        ),

        // County Dropdown (visible only if counties are loaded)
        Obx(() {
          if (widget.controller.isLoadingDropoffCounties.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.controller.selectedDropoffCountryId.value != 0) {
            if (widget.controller.dropoffCounties.isEmpty) {
              return Text("No counties available");
            }
            return CustomDropdown<String>(
              value: selectedCounty,
              items: widget.controller.dropoffCounties.map((county) => county.name!).toList(),
              onChanged: (value) {
                var county = widget.controller.dropoffCounties.firstWhere((e) => e.name == value);
                widget.controller.selectedDropoffCountyId.value = county.id!;
                widget.parcelController.toSelectedCountyId.value = county.id!;
                widget.controller.fetchDropoffZones(county.id!); // Fetch dropoff zones
                widget.controller.selectedDropoffZoneId.value = 0; // Reset dropoff zone selection
                widget.controller.selectedDropoffSubZoneId.value = 0; // Reset dropoff subzone selection
                widget.controller.selectedDropoffFSSpotId.value = 0; // Reset dropoff fs-spot selection
              },
              labelText: 'Select County',
              hintText: 'county',
            );
          } else {
            return SizedBox.shrink(); // Hide if no counties are loaded
          }
        }),
        Obx(
          () => (widget.controller.selectedDropoffCountyId.value != 0 && widget.controller.dropoffZones.isNotEmpty) ? SizedBox(height: 16) : SizedBox.shrink(),
        ),

        // Zone Dropdown (visible only if zones are loaded)
        Obx(() {
          if (widget.controller.isLoadingDropoffZones.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.controller.selectedDropoffCountyId.value != 0) {
            if (widget.controller.dropoffZones.isEmpty) {
              return Text("No zones available");
            }
            return CustomDropdown<String>(
              value: selectedZone,
              items: widget.controller.dropoffZones.map((zone) => zone.name!).toList(),
              onChanged: (value) {
                var zone = widget.controller.dropoffZones.firstWhere((zone) => zone.name == value);
                widget.controller.selectedDropoffZoneId.value = zone.id!;
                widget.parcelController.toSelectedZoneId.value = zone.id!;
                widget.controller.fetchDropoffSubZones(zone.id!); // Fetch dropoff subzones
                widget.controller.selectedDropoffSubZoneId.value = 0; // Reset dropoff subzone selection
                widget.controller.selectedDropoffFSSpotId.value = 0; // Reset dropoff fs-spot selection
              },
              labelText: 'Select Zone',
              hintText: 'zone',
            );
          } else {
            return SizedBox.shrink(); // Hide if no zones are loaded
          }
        }),
        Obx(
          () => (widget.controller.selectedDropoffZoneId.value != 0 && widget.controller.dropoffSubZones.isNotEmpty) ? SizedBox(height: 16) : SizedBox.shrink(),
        ),

        // SubZone Dropdown (visible only if subzones are loaded)
        Obx(() {
          if (widget.controller.isLoadingDropoffSubZones.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.controller.selectedDropoffZoneId.value != 0) {
            if (widget.controller.dropoffSubZones.isEmpty) {
              return Text("No subzones available");
            }
            return CustomDropdown<String>(
              value: selectedSubZone,
              items: widget.controller.dropoffSubZones.map((subZone) => subZone.name!).toList(),
              onChanged: (value) {
                var subzone = widget.controller.dropoffSubZones.firstWhere((e) => e.name == value);
                widget.controller.selectedDropoffSubZoneId.value = subzone.id!;
                widget.parcelController.toSelectedSubZoneId.value = subzone.id!;
                widget.controller.fetchDropoffFSSpots(subzone.id!); // Fetch dropoff fs-spots
                widget.controller.selectedDropoffFSSpotId.value = 0; // Reset dropoff fs-spot selection
              },
              labelText: 'Select SubZone',
              hintText: 'sub-zone',
            );
          } else {
            return SizedBox.shrink(); // Hide if no subzones are loaded
          }
        }),
        Obx(
          () => (widget.controller.selectedDropoffSubZoneId.value != 0 && widget.controller.dropoffFSSpots.isNotEmpty) ? SizedBox(height: 16) : SizedBox.shrink(),
        ),

        // FSSpot Dropdown (visible only if fs-spots are loaded)
        Obx(() {
          if (widget.controller.isLoadingDropoffFSSpots.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.controller.selectedDropoffSubZoneId.value != 0) {
            if (widget.controller.dropoffFSSpots.isEmpty) {
              return Text("No fs-spots available");
            }
            return CustomDropdown<String>(
              value: selectedFS,
              items: widget.controller.dropoffFSSpots.map((fsSpot) => fsSpot.name!).toList(),
              onChanged: (value) {
                var fs = widget.controller.dropoffFSSpots.firstWhere((e) => e.name == value);
                widget.controller.selectedDropoffFSSpotId.value = fs.id!;
                widget.parcelController.toSelectedFSSpotId.value = fs.id!;
              },
              labelText: 'Select FSSpot',
              hintText: 'fs-spot',
            );
          } else {
            return SizedBox.shrink(); // Hide if no fs-spots are loaded
          }
        }),
      ],
    );
  }
}
