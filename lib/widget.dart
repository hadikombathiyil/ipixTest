import 'package:flutter/material.dart';

import 'restaurentMOdel.dart';

class hotelwidgets extends StatelessWidget {
  hotelwidgets({super.key, required this.data, required this.index});

  final Restaurant data;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 5),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        width: double.infinity,
        height: 370,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 240,
              color: Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Row(
                children: [
                  Text(
                    data.name.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    width: 45,
                    height: 18,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Text(data.reviews![0].rating.toString(),
                                style: const TextStyle(color: Colors.white))),
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: Row(
                children: [
                  const CircleAvatar(
                      backgroundColor: Colors.black12,
                      maxRadius: 10,
                      child: Center(
                          child: Icon(
                        Icons.clear,
                        size: 20,
                        color: Colors.white,
                      ))),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    data.cuisineType.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13, right: 15, top: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.black12,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(data.address.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
