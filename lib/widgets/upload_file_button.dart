import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';

class UploadFileButton extends StatefulWidget {
  const UploadFileButton({super.key});

  @override
  State<UploadFileButton> createState() => _UploadFileButtonState();
}

class _UploadFileButtonState extends State<UploadFileButton> {
  Future<void> _selectAndUploadFile() async {
    file_picker.FilePickerResult? result =
        await file_picker.FilePicker.platform.pickFiles(
      type: file_picker.FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
    );

    if (result != null) {
      if (result.isSinglePick) {
        List<int> bytes = result.files.single.bytes!;
        _uploadFile(bytes);
      }
    }
  }

  Future<void> _uploadFile(List<int> bytes) async {
    if (bytes.isEmpty) {
      return;
    }

    String url = 'YOUR_UPLOAD_ENDPOINT_URL';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['content-type'] =
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: 'excel_file.xlsx',
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      // Handle successful upload.
    } else {
      // Handle failed upload.
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return TextButton(
      onPressed: _selectAndUploadFile,
      style: theme.textButtonTheme.style!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            MaterialIcons.cloudUpload,
            size: deviceWidth / 75,
          ),
          SizedBox(width: deviceWidth / 340),
          Text(Labels.uploadFile,
              style: textTheme.bodySmall?.copyWith(
                  color: colorTheme.secondary, fontSize: deviceWidth / 100)),
        ],
      ),
    );
  }
}
