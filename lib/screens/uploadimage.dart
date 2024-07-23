import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  Future getImage() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (PickedFile != null) {
      setState(() {
        _image = File(PickedFile.path);
      });
    } else {
      print('Image not Found');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(_image!.openRead().cast());
    stream.cast();
    //openRead() is a method of File class
    var length = await _image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = 'Kapoor';
    var multipartFile = new http.MultipartFile(
      'image',
      stream,
      length,
    );
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image Uploaded');
      setState(() {
        showSpinner = false;
      });
    } else {
      print('Image not Uploaded');
      setState(() {
        showSpinner = false;
      });
    }
  }

  File? _image;
  final picker = ImagePicker();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              'Upload Images on Server',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey.shade900),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                child: _image == null
                    ? Center(
                        child: Text('pick Image'),
                      )
                    : Container(
                        child: Center(
                          child: Image.file(File(_image!.path).absolute),
                        ),
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_image!), fit: BoxFit.cover)),
                      ),
              ),
            ),
            SizedBox(
              height: 220,
            ),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    'Upload Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
