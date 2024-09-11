import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_demo/core/services/api_constance.dart';

class ImageGalleryController extends GetxController {
  ApiConstants apiConstants = ApiConstants();

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  var page = 1.obs;
  var query = ''.obs;
  var isLoading = false.obs;
  var images = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchImages();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoading.value) {
        fetchImages();
      }
    });

    searchController.addListener(() {
      query.value = searchController.text;
      images.clear();
      page.value = 1;
      fetchImages();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchImages() async {
    if (isLoading.value) return;

    isLoading.value = true;

    final url = apiConstants.getImage(query: query.value, page: page.value);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      images.addAll(data['hits']);
      page.value++;
    } else {
      throw Exception('Failed to load images');
    }
    isLoading.value = false;
  }
}
