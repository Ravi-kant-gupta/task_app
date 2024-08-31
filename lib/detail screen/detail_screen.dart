import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/home/home_screen_controller.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});
  final HomeScreenController controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.white,
          title: const Text("Back"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.3,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          fit: BoxFit.cover,
                          controller.selectedCard[0]?.urlToImage ?? ''),
                    ),
                    Obx(() {
                      return (controller.isFav.value == true)
                          ? Positioned(
                              top: 20,
                              right: 20,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ))
                          : SizedBox.shrink();
                    })
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.calendar_month, size: 16),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      DateFormat("EEE, d MMM yyyy HH:mm 'GMT'").format(
                        DateTime.parse(
                          controller.selectedCard[0]?.publishedAt ?? '',
                        ).toUtc(),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                controller.selectedCard[0]?.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(),
              ),
            ],
          ),
        ));
  }
}
