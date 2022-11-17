import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/api.dart';

import 'package:dio/dio.dart' as dio;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fileName = "";
  late File file;

  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    file = File(result.files.single.path!);
                    setState(() {
                      fileName = file.path;
                      isUploaded = true;
                    });
                  } else {
                    // User canceled the picker
                  }

                  // var picked = await FilePicker.platform.pickFiles();

                  // if (picked != null) {
                  //   print(picked.files.first.name);
                  //   setState(() {
                  //   fileName = picked.files.first.name;
                      
                  //   });
                  //   // isUploaded = true;
                  // }
                },
                child: const Text("Choose File"),
              ),
              const SizedBox(height: 20),
              Text(fileName),
              const SizedBox(height: 20),
              isUploaded ? Image.file(file) : const SizedBox(),
              ElevatedButton(
                  onPressed: () async {
                    dio.FormData formData;

                    formData = dio.FormData.fromMap({
                      "sendimage": await dio.MultipartFile.fromFile(file.path,
                          filename: file.path.split('/').last),
                    });

                    APIServices.uploadFile(formData).then((value) {
                      setState(() {
                        fileName = (value.status == 200
                            ? value.status.toString()
                            : value.status.toString());
                      });
                    });
                  },
                  child: const Text("Upload"))
            ],
          ),
        ),
      ),
    );
  }
}
