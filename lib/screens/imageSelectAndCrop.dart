import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectAndCrop extends StatefulWidget {
  @override
  _ImageSelectAndCropState createState() => _ImageSelectAndCropState();
}

class _ImageSelectAndCropState extends State<ImageSelectAndCrop> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  // Future<void> _cropImage() async {
  //   File cropped = await ImageCropper.cropImage(
  //       sourcePath: _imageFile.path,
  //       // ratioX: 1.0,
  //       // ratioY: 1.0,
  //       // maxWidth: 512,
  //       // maxHeight: 512,
  //       toolbarColor: Colors.purple,
  //       toolbarWidgetColor: Colors.white,
  //       toolbarTitle: 'Crop It'
  //   );
  //
  //   setState(() {
  //     _imageFile = cropped ?? _imageFile;
  //   });
  // }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    ImagePicker _picker = ImagePicker();
    PickedFile selected = await _picker.getImage(source: source);

    setState(() {
      // _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),

            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  // onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),

            // Uploader(file: _imageFile)
          ]
        ],
      ),
    );
  }
}
