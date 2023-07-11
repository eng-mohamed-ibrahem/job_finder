import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../cubit/edit_profile_screens_cubit/file_path_cubit.dart';

void pickImage(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  pickImageFromCamera(context);
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/icons/camera_picker.png'),
                    ),
                  ],
                ),
              ),

              //! ------------------------------------------------------------------!//

              GestureDetector(
                onTap: () {
                  pickImageFromGallery(context);
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/icons/gallery_picker.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void pickImageFromCamera(BuildContext context) async {
  var permission = await Permission.camera.request();
  if (permission.isDenied) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please allow access to camera',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    permission = await Permission.camera.request();

    if (permission.isPermanentlyDenied) {
      openAppSettings();
    }
  }
  if (permission.isGranted || permission.isLimited) {
    if (context.mounted) {
      Navigator.pop(context);
    }
    try {
      await ImagePicker().pickImage(source: ImageSource.camera).then(
        (profileImage) {
          if (profileImage != null) {
            // save image to local device
            BlocProvider.of<FilePathCubit>(context)
                .setImagePath(profileImage.path);
          }
        },
      );
    } on FileSystemException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }
    }
  }
}

void pickImageFromGallery(BuildContext context) async {
  var permission = await Permission.photos.request();

  if (permission.isDenied) {
    log(permission.toString());
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please allow access to gallery',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    permission = await Permission.photos.request();
    if (permission.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  log(permission.toString());
  if (permission.isGranted || permission.isLimited) {
    if (context.mounted) {
      Navigator.pop(context);
    }
    try {
      await ImagePicker().pickImage(source: ImageSource.gallery).then(
        (profileImage) {
          if (profileImage != null) {
            BlocProvider.of<FilePathCubit>(context)
                .setImagePath(profileImage.path);
          }
        },
      );
    } on FileSystemException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }
    }
  }
}

/// pick pdf file
void pickFile(BuildContext context) async {
  // step 1: check permission
  // Permission.storage.request();
  var permission = await Permission.manageExternalStorage.request();
  log(permission.toString());
  if (permission.isDenied) {
    permission = await Permission.manageExternalStorage.request();
    if (permission.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  log(permission.toString());
  if (permission.isGranted || permission.isLimited) {
    try {
      // step 2: pick file
      await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']).then(
        (pickedFile) {
          if (pickedFile != null) {
            BlocProvider.of<FilePathCubit>(context)
                .setPdfPath(pickedFile.files.first.path!);
          }
        },
      );
    } on FileSystemException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }
    }
  }
}
