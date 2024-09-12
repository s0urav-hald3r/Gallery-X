import 'package:get/get.dart';
import '../models/image_model.dart';
import '../services/api_service.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  // Variables
  final _images = <ImageModel>[].obs;
  final _isLoading = false.obs;
  int _page = 1;
  final _query = ''.obs;

  final ApiService apiService = ApiService();

  // Getters
  List<ImageModel> get images => _images;
  bool get isLoading => _isLoading.value;
  int get page => _page;
  String get query => _query.value;

  // Setters
  set images(newImages) => _images.value = newImages;
  set isLoading(status) => _isLoading.value = status;
  set page(value) => _page = value;
  set query(newQuery) => _query.value = newQuery;

  @override
  void onInit() {
    debounce(_query, (_) => searchImages(), time: const Duration(seconds: 1));
    loadMoreImages();
    super.onInit();
  }

  void loadMoreImages({bool loadMore = false}) async {
    if (isLoading) return;
    if (!loadMore) isLoading = true;
    var newImages = await apiService.fetchImages(query, page);
    images.addAll(newImages);
    page = page + 1;
    if (!loadMore) isLoading = false;
  }

  void searchImages() async {
    if (isLoading) return;
    isLoading = true;
    page = 1;
    images = <ImageModel>[];
    var newImages = await apiService.fetchImages(query, page);
    images.addAll(newImages);
    page = page + 1;
    isLoading = false;
  }
}
