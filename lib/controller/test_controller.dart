import 'dart:convert';

import 'package:get/get.dart';
import 'package:street_light_management/controller/base_controller.dart';
import 'package:street_light_management/helper/dialog_helper.dart';
import 'package:street_light_management/services/app_exception.dart';
import 'package:street_light_management/services/base_client.dart';


class TestController extends GetxController with BaseController {
  void getData() async {
    showLoading('Fetching data');
    var response = await BaseClient().get( '/todos/1').catchError(handleError);
    if (response == null) return;
    hideLoading();
    print(response);
  }

  void postData() async {
    var request = {'message': 'CodeX sucks!!!'};
    showLoading('Posting data...');
    var response = await BaseClient().post('/posts', request).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    hideLoading();
    print(response);
  }
}