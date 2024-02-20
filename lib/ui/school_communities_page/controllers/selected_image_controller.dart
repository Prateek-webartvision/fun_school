import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class SelectedImagesController extends GetxController {
  List<PlatformFile> selectedImages = [];

  addImage(PlatformFile image) {
    selectedImages.add(image);
    update();
  }

  addImages(List<PlatformFile> images) {
    selectedImages.addAll(images);
    update();
  }

  remove(PlatformFile image) {
    selectedImages.remove(image);
    update();
  }

  clearImages() {
    selectedImages.clear();
    update();
  }
}
