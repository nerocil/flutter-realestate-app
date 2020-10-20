import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class NavigationBottomController extends GetxController{
  var currentIndex = 0.obs;
  var pageController = PageController().obs;

  updateIndex({@required int index}){
    currentIndex.value = index;
    pageController.value.jumpToPage(index);
  }
}