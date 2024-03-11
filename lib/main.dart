import 'package:flutter/material.dart';
import 'package:google_map_test/homepage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: hompage());
  }
}

class Click extends StatelessWidget {
  const Click({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GoogleMapTest(),
          )),
          child: Container(
            height: 50,
            width: 100,
            color: Colors.blue,
            child: Center(
              child: Text("Click"),
            ),
          ),
        ),
      ),
    );
  }
}
// 11.248946, 75.833498

class GoogleMapTest extends StatelessWidget {
  GoogleMapTest({super.key});

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
                          target: LatLng(snapshot.data!.latitude!,
                              snapshot.data!.longitude!),
                          zoom: 15),
                      markers: {
                        // Marker(
                        //   markerId: const MarkerId('1'),
                        //   position: LatLng(11.248946, 75.833498),
                        // )
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
