import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:postbar/core/base/index.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/model/index.dart';
import 'package:postbar/network/index.dart';

abstract class IHomeProvider {}

class HomeProvider extends BaseProvider implements IHomeProvider {}

abstract class IHomeRepository {
  List<String?>? getDesignPostList({required VkUser? user});
  List<String?>? getDesignStoryList({required VkUser? user});
  Future<VkUser?> getUserInfo({required String uid});
}

class HomeRepository extends BaseRepository<HomeProvider> implements IHomeRepository {
  HomeRepository() : super(provider: HomeProvider());

  @override
  List<String?>? getDesignPostList({required VkUser? user}) {
    if (user == null) {
      return null;
    }
    return user.designPostList;
  }

  @override
  List<String?>? getDesignStoryList({required VkUser? user}) {
    if (user == null) {
      return null;
    }
    return user.designStoryList;
  }

  @override
  Future<VkUser?> getUserInfo({required String? uid}) async {
    if (uid == null) {
      return null;
    }

    final DataSnapshot _snapshot = await GlobalVariables.firebase.firebaseDatabaseRef.child(uid).get();

    if (_snapshot.exists) {
      debugPrint("GetUserInfo: ${_snapshot.value}");
      return VkUser(_snapshot.value);
    } else {
      debugPrint('GetUserInfoError: No data available.');
      return null;
    }
  }
}
