import 'package:get/get.dart';
import 'package:task_app/home/home_repository.dart';
import 'package:task_app/home/models.dart';

class HomeScreenController extends GetxController {
  HomeScreenResponse? res;
  RxDouble dragAmount = 0.0.obs;
  RxList<int> showFav = <int>[].obs;
  RxList<Articles> data = <Articles>[].obs;
  RxList<int> favData = <int>[].obs;
  RxString selectedScreen = 'news'.obs;
  RxList<Articles?> selectedCard = <Articles?>[].obs;
  RxBool isFav = false.obs;

  @override
  void onInit() async {
    super.onInit();
    res = await HomeRepository().homeApiMethod();
    data.value = res!.articles ?? [];
    print(res?.articles?.length);
  }
}
