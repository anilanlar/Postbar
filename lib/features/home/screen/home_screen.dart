import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import "package:flutter/material.dart";

import "package:get/get.dart";
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/features/home/index.dart';
import 'package:postbar/model/index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_routes.dart';
import '../../../ui/widgets/custom_widgets/custom_gradient_button.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    const double _horizontalPadding = 40;
    const double _verticalPadding = 40;
    final int _designRowCount = _width >= 900
        ? 4
        : _width >= 600
            ? 3
            : 2;
    final double _designSpacing = _width * 0.05;
    final double _designWidth = ((_width -
                (_horizontalPadding * 2) -
                (_designSpacing * (_designRowCount - 1))) /
            _designRowCount) -
        0.01;
    const double _aspectRatio = 1;
    final double _designHeight = _designWidth * (1 / _aspectRatio);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: const Key("home_screen_scaffold"),
        body: Padding(
          padding: const EdgeInsets.only(
              top: _verticalPadding,
              right: _horizontalPadding,
              left: _horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    GlobalVariables.images.appLogoPath,
                    width: 100,
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: CustomDropDownMenu(context),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.settings_power,
                    //   ),
                    //   iconSize: 40,
                    //   color: ThemeColors.secondaryColor,
                    //   splashColor: Colors.purple,
                    //   onPressed: () {
                    //     controller.signOut();
                    //   },
                    // ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Obx(
                () => RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: controller.pageTitle,
                        style: TextStyles.headline5,
                      ),
                      TextSpan(
                        text: controller.distributorName.value,
                        style: TextStyles.headline5.copyWith(
                          color: ThemeColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                controller.pageDescription,
                style: TextStyles.headline5,
              ),
              // SizedBox(height: 30),

              Expanded(child: Obx(() {
                if (controller.areDesignsLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final List<Widget> _children = <Widget>[];

                  int _cachedLength = 0;
                  if (controller.designURLList != null) {
                    _cachedLength = controller.designURLList!.value.length;
                  } else {
                    debugPrint("cachedLength could not be assigned");
                  }

                  for (int i = 0; i < _cachedLength; i++) {
                    String designURL =
                        controller.designURLList!.value.elementAt(i)!;

                    _children.add(
                      DesignContainer(
                        onTap: () => controller.designOnTapped(
                            chosenImageURL: designURL),
                        // onTap: () => {print("designTapped")},

                        imageURL: designURL,
                        width: _designWidth,
                        height: _designHeight,
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _topButtons(),
                        ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          cacheExtent: _designHeight + _designSpacing,
                          addAutomaticKeepAlives: true,
                          addRepaintBoundaries: false,
                          itemCount: (_children.length ~/ _designRowCount) + 1,
                          itemBuilder: (BuildContext context, int index) {
                            final List<Widget> _rowWidgets = <Widget>[];
                            for (int i = 0; i < _designRowCount; i++) {
                              try {
                                _rowWidgets.add(
                                    _children[(index * _designRowCount) + i]);
                                if (i != _designRowCount - 1) {
                                  _rowWidgets.add(const Spacer());
                                }
                              } catch (e) {
                                debugPrint("Can't add new design to the list");
                              }
                            }
                            return Padding(
                              padding: EdgeInsets.only(bottom: _designSpacing),
                              child: SizedBox(
                                height: _designHeight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _rowWidgets,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              })),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _topButtons() {
  return Container(
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 170,
          child: CustomGradientButton(
            fontSize: 10,
            // gradient: const LinearGradient(
            //   colors: <Color>[
            //     ThemeColors.thirdColor,
            //      ThemeColors.fourthColor,
            //   ],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),
            text: "Postlar".tr.toUpperCase(),
            onPressed: () {},
          ),
        ),
        Container(
          width: 170,
          child: CustomGradientButton(
            fontSize: 10,
            // gradient: const LinearGradient(
            //   colors: <Color>[
            //     ThemeColors.thirdColor,
            //      ThemeColors.fourthColor,
            //   ],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),
            text: "Hikayeler".tr.toUpperCase(),
            onPressed: () {
              Get.snackbar("YAKINDA",
                  "Şubenize özel tasarlanmış hikayeler çok yakında sizlerle",
                  colorText: Colors.white,
                  backgroundGradient: const LinearGradient(
                    colors: <Color>[
                      ThemeColors.thirdColor,
                       ThemeColors.fourthColor,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

class DesignContainer extends StatefulWidget {
  const DesignContainer({
    Key? key,
    this.onTap,
    required this.imageURL,
    required this.width,
    required this.height,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String imageURL;
  final double width;
  final double height;

  @override
  State<DesignContainer> createState() => _DesignContainerState();
}

class _DesignContainerState extends State<DesignContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            elevation: 4,
            child: AnimatedContainer(
              clipBehavior: Clip.hardEdge,
              duration: const Duration(milliseconds: 100),
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: null,
              ),
              child: CachedNetworkImage(
                imageUrl: widget.imageURL ?? '',
                imageBuilder: (BuildContext context,
                        ImageProvider<Object> imageProvider) =>
                    Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (BuildContext context, String url) => const Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                errorWidget:
                    (BuildContext context, String url, dynamic error) =>
                        const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DesignEmptyContainer extends GetView<HomeController> {
  const DesignEmptyContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade300,
      ),
    );
  }
}

Widget CustomDropDownMenu(BuildContext context) {
  return DropdownButtonHideUnderline(
    child: DropdownButton2(
      customButton: const Icon(
        Icons.list,
        size: 46,
        color: ThemeColors.secondaryColor,
      ),
      customItemsHeights: [
        ...List<double>.filled(MenuItems.firstItems.length, 48),
        18,
        ...List<double>.filled(MenuItems.secondItems.length, 48),
      ],
      items: [
        ...MenuItems.firstItems.map(
          (item) => DropdownMenuItem(
            value: item,
            child: MenuItems.buildItem(item),
          ),
        ),
        const DropdownMenuItem<Divider>(
            enabled: false,
            child: Divider(
              color: Colors.white,
              thickness: 2,
            )),
        ...MenuItems.secondItems.map(
          (item) => DropdownMenuItem(
            value: item,
            child: MenuItems.buildItem(item),
          ),
        ),
      ],
      onChanged: (value) {
        MenuItems.onChanged(context, value as MenuItem);
      },
      itemHeight: 48,
      itemPadding: const EdgeInsets.only(left: 16, right: 16),
      dropdownWidth: 160,
      dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ThemeColors.secondaryColor,
      ),
      dropdownElevation: 8,
      offset: const Offset(0, 8),
    ),
  );
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [share];
  static const List<MenuItem> secondItems = [logout];

  static const share = MenuItem(text: 'İletişim', icon: Icons.share);
  static const logout = MenuItem(text: 'Çıkış Yap', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.share:
        try {
          launchUrl(Uri.parse("whatsapp://send?phone=+905376759017"));
        } catch (e) {
          debugPrint("LaunchWhatsappError: $e");
        }
        break;
      case MenuItems.logout:
        try {
          GlobalVariables.firebase.firebaseAuth.signOut();
          Get.offAllNamed(AppRoutes.LOGIN);
        } catch (e) {
          debugPrint("SignOut Error: $e");
          SnackbarToastUtil.showErrorSnackbar(
            title: "Hata",
            message: "Hesaptan çıkış başarısız".tr,
          );
        }
        break;
    }
  }
}
