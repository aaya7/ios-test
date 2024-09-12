import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/models/misc_models/dropdown_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/auth_repository.dart';
import 'package:hero/app/data/repositories/misc_repositories/misc_repository.dart';
import 'package:hero/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final stateSelected = Rxn<String>();
  final citySelected = Rxn<DropdownModel>();
  final sourceSelected = Rxn<DropdownModel>();

  final stateList = <String>[].obs;

  final cityList = <DropdownModel>[].obs;
  final sourceList = <DropdownModel>[].obs;

  final checkBoxAgree = false.obs;

  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchSources();
    await fetchState();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> register() async {
    try {
      isLoading(true);

      await AuthRepository.instance.register(
          name: nameTextController.text,
          email: emailTextController.text,
          mobile: mobileTextController.text,
          state: stateSelected.value ?? '',
          city: citySelected.value?.name ?? '',
          password: passwordTextController.text,
          passwordConfirmation: confirmPasswordTextController.text,
          source: sourceSelected.value?.code ?? '');

      snackBarSuccess(context: Get.context!, content: "Register success");

      Get.offNamed(Routes.LOGIN);
    } catch (error, st) {
      snackBarFailed(
          context: Get.context!,
          content:
              (error as CustomException).message.toString().removeException);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchState() async {
    try {
      stateList(await MiscRepository.instance.getState());
    } catch (error) {
      snackBarFailed(context: Get.context!, content: "Fail to fetch states");
    }
  }

  Future<void> fetchCities({required String state}) async {
    try {
      cityList(await MiscRepository.instance.getCities(state: state));
    } catch (error) {
      snackBarFailed(context: Get.context!, content: "Fail to fetch cities");
    }
  }

  Future<void> fetchSources() async {
    try {
      sourceList(await MiscRepository.instance.getRegistrationSource());
    } catch (error) {
      snackBarFailed(context: Get.context!, content: "Fail to fetch sources");
    }
  }
}
