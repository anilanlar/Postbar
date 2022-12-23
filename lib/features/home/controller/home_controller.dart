import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postbar/core/base/index.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/features/export/controller/export_controller.dart';
import 'package:postbar/features/home/index.dart';
import 'package:postbar/model/index.dart';
import 'package:postbar/routes/index.dart';
import 'package:postbar/ui/widgets/custom_widgets/index.dart';

class HomeController extends BaseRepositoryController<HomeRepository, HomeProvider, List<Design>?> {
  HomeController() : super(repository: HomeRepository());

  VkUser? vkUser;
  Rx<List<String?>>? designPostURLList;
  Rx<List<String?>>? designStoryURLList;

  String? chosenDesignURL;
  final RxString distributorName = "".obs;
  RxBool areDesignsLoading = true.obs;

  final Set<Design> selectedDesignList = <Design>{};
  final RxBool selectedDesignListChangeListener = false.obs;

  RxString isPostorStory= RxString("Post");



  String get pageTitle {
    return "app.home.title".tr;
  }

  String get pageDescription {
    final List<String> months = <String>['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    final DateTime now = DateTime.now();
    final int currentMon = now.month;
    return months[currentMon - 1] + "app.home.description".tr;
  }




  void designOnTapped({required String chosenImageURL}) {
    chosenDesignURL = chosenImageURL;
    Get.toNamed(AppRoutes.EXPORT);
  }


  Future<VkUser?> _getUserInfo() async {
    debugPrint("VK USER AVAILABLE ");
    CustomProgressIndicator.openLoadingDialog();

    vkUser = await repository.getUserInfo(uid: GlobalVariables.firebase.firebaseAuth.currentUser?.uid);

    if (vkUser?.title != null) {
      distributorName.value = vkUser!.title!;
    }
     CustomProgressIndicator.closeLoadingOverlay();
    return vkUser;

  }

  void _getDesignList(VkUser? user) {
    CustomProgressIndicator.openLoadingDialog();
    final List<String?>? _designPosts = repository.getDesignPostList(user: user);
    final List<String?>? _designStories = repository.getDesignStoryList(user: user);

    designPostURLList = Rx<List<String?>>(_designPosts!);
    designStoryURLList = Rx<List<String?>>(_designStories!);

    areDesignsLoading.value = false;
    CustomProgressIndicator.closeLoadingOverlay();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    selectedDesignList.clear();
    VkUser? user = await _getUserInfo();
    _getDesignList(user);
    // append(() => _getDesignList);
  }
}
