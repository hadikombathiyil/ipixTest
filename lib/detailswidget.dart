import 'package:flutter/material.dart';
import 'package:google_map_test/restaurentMOdel.dart';

class detailwidget extends StatelessWidget {
  const detailwidget({super.key, required this.data});

  final Review data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 200,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ], color: Colors.red, borderRadius: BorderRadius.circular(10)),
                width: 45,
                height: 18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(data.rating.toString(),
                            style: const TextStyle(color: Colors.white))),
                    const Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                data.name.toString(),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(data.comments.toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Text(data.date.toString()),
          )
        ],
      ),
    );
  }
}
