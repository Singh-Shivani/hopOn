// import 'dart:io';
//
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImageSelectAndCrop extends StatefulWidget {
//   @override
//   _ImageSelectAndCropState createState() => _ImageSelectAndCropState();
// }
//
// class _ImageSelectAndCropState extends State<ImageSelectAndCrop> {
//   /// Active image file
//   File _imageFile;
//
//   /// Initialize firebase storage
//   firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instanceFor(
//           bucket: 'gs://hopon-3d89e.appspot.com');
//
//   /// Cropper plugin
//   Future<void> _cropImage(File image) async {
//     File cropped = await ImageCropper.cropImage(
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//       ],
//       cropStyle: CropStyle.circle,
//       compressQuality: 60,
//       sourcePath: image.path,
//     );
//
//     setState(() {
//       _imageFile = cropped;
//     });
//   }
//
//   /// Select an image via gallery or camera
//   Future<void> _pickImage(ImageSource source) async {
//     ImagePicker _picker = ImagePicker();
//     File selected;
//
//     await _picker.getImage(source: source).then((value) {
//       selected = File(value.path);
//       _cropImage(selected);
//     }).catchError((e) => print(e));
//   }
//
//   /// Remove image
//   void _clear() {
//     setState(() => _imageFile = null);
//   }
//
//   /// Starts an upload task
//   void _startUpload() {
//     firebase_storage.Reference _ref =
//         storage.ref().child('${DateTime.now()}.png');
//
//     _ref.putFile(_imageFile).then(
//           (_) => _ref
//               .getDownloadURL()
//               .then((url) => Navigator.pop(context, url))
//               .catchError((e) => print(e.message)),
//         );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Select an image from the camera or gallery
//       bottomNavigationBar: BottomAppBar(
//         child: Center(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.photo_camera,
//                     size: 30,
//                   ),
//                   onPressed: () => _pickImage(ImageSource.camera),
//                 ),
//               ),
//               Expanded(
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.photo_library,
//                     size: 30,
//                   ),
//                   onPressed: () => _pickImage(ImageSource.gallery),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//
//       // Preview the image and crop it
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
//         child: ListView(
//           children: <Widget>[
//             if (_imageFile != null) ...[
//               Image.file(
//                 _imageFile,
//                 fit: BoxFit.cover,
//               ),
//               Center(
//                 child: FlatButton(
//                   child: Icon(Icons.refresh),
//                   onPressed: _clear,
//                 ),
//               ),
//               Center(
//                 child: FlatButton(
//                   child: Icon(Icons.done),
//                   onPressed: _startUpload,
//                 ),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }
