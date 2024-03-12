import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_map_test/widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'detailspage.dart';
import 'loginpage.dart';
import 'restaurentMOdel.dart';

class hompage extends StatefulWidget {
  const hompage({super.key});

  @override
  State<hompage> createState() => _hompageState();
}

class _hompageState extends State<hompage> {
  Future<Ipixrestaurant?> apiCall() async {
    try {
      var url = "https://run.mocky.io/v3/9c7d5c0d-5dd9-4b72-b158-fcf4f61a956b";
      var response = await http.get(Uri.parse(url));
      print(response.body);
      var data = jsonDecode(response.body);
      var data1 = Ipixrestaurant.fromJson(data);
      return data1;
    } catch (e) {
      throw Exception("Error Occured$e");
    }
  }

  void logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => logoutUser(context),
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 14,
                    ),
                    Text(
                      "Log out",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffFF8C23),
          toolbarHeight: 60,
          title: const Text(
            "REATAURANTS",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          )),
      body: FutureBuilder(
          future: apiCall(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.hasError.toString()),
              );
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.restaurants!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => detailspage(
                                      data: snapshot.data!.restaurants![index]),
                                )),
                            child: hotelwidgets(
                              data: snapshot.data!.restaurants![index],
                              index: index,
                            ));
                      },
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
