import 'package:flutter/material.dart';
import 'package:google_map_test/detailswidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'restaurentMOdel.dart';

class detailspage extends StatefulWidget {
  const detailspage({Key? key, required this.data});

  final Restaurant data;

  @override
  State<detailspage> createState() => _detailspageState();
}

class _detailspageState extends State<detailspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 230,
            // child: Image.network(
            //   widget.data.photograph.toString(),
            //   fit: BoxFit.fill,
            // ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
            child: Row(
              children: [
                Text(
                  widget.data.name.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 45,
                  height: 18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(widget.data.reviews![0].rating.toString(),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      const Icon(Icons.star, size: 15, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Text(
              widget.data.neighborhood.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.black12,
                  maxRadius: 10,
                  child: Center(
                    child: Icon(Icons.clear, size: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.data.cuisineType.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 15, top: 8),
            child: Row(
              children: [
                const Icon(Icons.location_pin, color: Colors.black12),
                const SizedBox(width: 2),
                Text(widget.data.address.toString()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 15, top: 8),
            child: Row(
              children: [
                const Icon(Icons.access_time_filled, color: Colors.black12),
                const SizedBox(width: 2),
                Text(widget.data.operatingHours!.tuesday.toString()),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Text(
              "Rating & Reviews",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 9, right: 9),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return detailwidget(
                    data: widget.data.reviews![index],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.data.reviews!.length),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFF8C23),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GoogleMapTest(
              lat: widget.data.latlng!.lat,
              long: widget.data.latlng!.lng,
            ),
          ));
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_outlined,
              color: Colors.white,
            ),
            Text(
              "GO",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class GoogleMapTest extends StatelessWidget {
  GoogleMapTest({super.key, required this.lat, required this.long});
  var lat;
  var long;

  Location location = Location();
  LocationData? _locationData;

  Future<LocationData> GetLoct() async {
    _locationData = await location.getLocation();
    return _locationData!;
  }

  Location lctn = Location();
  CameraPosition init =
      const CameraPosition(target: LatLng(11.248946, 75.833498), zoom: 15);

  cls() async {
    LocationData lctndata = await lctn.getLocation();
    print(lctndata.longitude);
    init = CameraPosition(
        target: LatLng(lctndata.latitude!, lctndata.longitude!), zoom: 15);
    print(init);
    mapController!.animateCamera(CameraUpdate.newCameraPosition(init));
  }

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: GetLoct(),
            builder: (context, AsyncSnapshot<LocationData> snapshot) {
              if (snapshot.hasError) {
                return const Text('map');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.red),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      myLocationButtonEnabled: true,
                      buildingsEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.hybrid,
                      mapToolbarEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(lat,
                              long),
                          zoom: 15),
                   
                      markers: {
                        Marker(
                          markerId: const MarkerId('1'),
                          position: LatLng(lat, long),
                        ),
                        const Marker(
                          markerId: MarkerId('1'),
                          position: LatLng(11.248946, 75.833498),
                        )
                      },
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
