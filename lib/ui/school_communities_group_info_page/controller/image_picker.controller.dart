import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ImagePickerController extends GetxController {
  PlatformFile? image;

  pick() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      allowCompression: true,
    );

    if (res != null) {
      final images = res.files;
      if (images.isNotEmpty) {
        image = images.first;
      }
    }
    update();
  }

  clear() {
    image = null;
  }
}
