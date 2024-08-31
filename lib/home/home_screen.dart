import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/detail%20screen/detail_screen.dart';
import 'package:task_app/home/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectedScreen.value = 'news';
                      controller.showFav.value = [];
                    },
                    child: Obx(() {
                      return Container(
                        width: Get.width * 0.3,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: controller.selectedScreen.value == 'news'
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.transparent),
                        child: const Row(
                          children: [
                            Icon(Icons.menu_sharp),
                            Text("News"),
                          ],
                        ),
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.selectedScreen.value = 'fav';
                      controller.showFav.value = [];
                    },
                    child: Obx(() {
                      return Container(
                        width: Get.width * 0.3,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: controller.selectedScreen.value == 'fav'
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.transparent),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            Text("Favs"),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
            Obx(() {
              if (controller.data.isNotEmpty) {
                return Obx(() {
                  if (controller.selectedScreen.value == 'news') {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: controller.res?.articles?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  controller.selectedCard.value =
                                      await [controller.res?.articles?[index]];
                                  if (controller.favData.contains(index)) {
                                    controller.isFav.value = true;
                                  } else {
                                    controller.isFav.value = false;
                                  }
                                  print(controller.selectedCard);
                                  Get.to(() => DetailScreen());
                                },
                                onHorizontalDragUpdate: (details) {
                                  if (details.delta.dx > 0) {
                                    if (controller.showFav.value
                                        .contains(index)) {
                                      controller.showFav.value = [];
                                    }
                                  } else {
                                    controller.showFav.value = [index];
                                  }
                                  print(details.delta.dx);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          controller.res?.articles?[index]
                                                  .urlToImage ??
                                              "",
                                          height: Get.height * 0.15,
                                          width: Get.width * 0.25,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.res?.articles?[index]
                                                      .title ??
                                                  '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              controller.res?.articles?[index]
                                                      .description ??
                                                  '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                const Icon(Icons.calendar_month,
                                                    size: 16),
                                                const SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    DateFormat(
                                                            "EEE, d MMM yyyy HH:mm 'GMT'")
                                                        .format(
                                                      DateTime.parse(
                                                        controller
                                                                .res
                                                                ?.articles?[
                                                                    index]
                                                                .publishedAt ??
                                                            '',
                                                      ).toUtc(),
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Obx(() {
                                        return (controller.showFav.value
                                                .contains(index))
                                            ? GestureDetector(
                                                onTap: () {
                                                  if (controller.favData
                                                      .contains(index)) {
                                                    controller.favData
                                                        .remove(index);
                                                    return;
                                                  }
                                                  controller.favData.add(index);
                                                },
                                                child: Container(
                                                  width: Get.width / 5,
                                                  height: Get.height / 7,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.5)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.favorite,
                                                        color: controller
                                                                .favData
                                                                .contains(index)
                                                            ? Colors.red
                                                                .withOpacity(
                                                                    0.95)
                                                            : Colors.white,
                                                      ),
                                                      const Text(
                                                          "Add to Favourite",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12))
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink();
                                      })
                                    ],
                                  ),
                                ),
                              );
                            }));
                  } else {
                    if (controller.favData.isNotEmpty) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: controller.res?.articles?.length,
                              itemBuilder: (context, index) {
                                if (controller.favData.contains(index)) {
                                  return GestureDetector(
                                    onTap: () async {
                                      controller.selectedCard.value = await [
                                        controller.res?.articles?[index]
                                      ];
                                      if (controller.favData.contains(index)) {
                                        controller.isFav.value = true;
                                      } else {
                                        controller.isFav.value = false;
                                      }
                                      print(controller.selectedCard);
                                      Get.to(() => DetailScreen());
                                    },
                                    onHorizontalDragUpdate: (details) {
                                      if (details.delta.dx > 0) {
                                        if (controller.showFav.value
                                            .contains(index)) {
                                          controller.showFav.value = [];
                                        }
                                      } else {
                                        controller.showFav.value = [index];
                                      }
                                      print(details.delta.dx);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: Image.network(
                                              controller.res?.articles?[index]
                                                      .urlToImage ??
                                                  "",
                                              height: Get.height * 0.15,
                                              width: Get.width * 0.25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                          .res
                                                          ?.articles?[index]
                                                          .title ??
                                                      '',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  controller
                                                          .res
                                                          ?.articles?[index]
                                                          .description ??
                                                      '',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.calendar_month,
                                                        size: 16),
                                                    const SizedBox(width: 5),
                                                    Expanded(
                                                      child: Text(
                                                        DateFormat(
                                                                "EEE, d MMM yyyy HH:mm 'GMT'")
                                                            .format(
                                                          DateTime.parse(
                                                            controller
                                                                    .res
                                                                    ?.articles?[
                                                                        index]
                                                                    .publishedAt ??
                                                                '',
                                                          ).toUtc(),
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Obx(() {
                                            return (controller.showFav.value
                                                    .contains(index))
                                                ? GestureDetector(
                                                    onTap: () {
                                                      if (controller.favData
                                                          .contains(index)) {
                                                        controller.favData
                                                            .remove(index);
                                                        return;
                                                      }
                                                      controller.favData
                                                          .add(index);
                                                    },
                                                    child: Container(
                                                      width: Get.width / 5,
                                                      height: Get.height / 7,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red
                                                              .withOpacity(
                                                                  0.5)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.favorite,
                                                            color: controller
                                                                    .favData
                                                                    .contains(
                                                                        index)
                                                                ? Colors.red
                                                                    .withOpacity(
                                                                        0.95)
                                                                : Colors.white,
                                                          ),
                                                          const Text(
                                                              "Add to Favourite",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 12))
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink();
                                          })
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }));
                    } else {
                      return const Center(
                        child: Text('No Fav Items'),
                      );
                    }
                  }
                });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
