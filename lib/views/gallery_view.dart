import 'package:flutter/material.dart';
import 'package:galleryx/widgets/image_card.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/image_controller.dart';

class GalleryView extends StatelessWidget {
  GalleryView({super.key});

  final imageController = ImageController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery X'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                imageController.query = value;
              },
              decoration: const InputDecoration(
                labelText: 'Search images...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    imageController.loadMoreImages(loadMore: true);
                  }
                  return true;
                },
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _calculateCrossAxisCount(context),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: imageController.isLoading
                      ? 10
                      : imageController.images.length,
                  itemBuilder: (context, index) {
                    if (imageController.isLoading) {
                      return Skeletonizer(
                          effect: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade50),
                          enabled: true,
                          child: const ImageCard());
                    }
                    final image = imageController.images[index];
                    return ImageCard(image: image);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth / 150)
        .floor(); // Adjust column count based on screen width
  }
}
