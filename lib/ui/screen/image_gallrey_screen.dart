import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:task_demo/ui/widget/full_screen_image_widget.dart';
import 'package:task_demo/core/controller/image_gallrey_controller.dart';

class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ImageGalleryController controller = Get.put(ImageGalleryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: const InputDecoration(
                hintText: 'Search images...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.images.isEmpty && controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : MasonryGridView.count(
                      controller: controller.scrollController,
                      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                      itemCount: controller.images.length,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        final image = controller.images[index];
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => FullScreenImage(image: image));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: image['webformatURL'],
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Likes: ${image['likes']}'),
                                      Text('Views: ${image['views']}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          Obx(() => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
