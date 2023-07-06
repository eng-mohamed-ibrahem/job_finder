import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/signup_screen_widget/customized_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class ImagePathCubit extends Cubit<String> {
  ImagePathCubit() : super('');

  void setImagePath(String path) {
    log("----- $path-----");
    emit(path);
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PhoneNumber? _phoneNumber;

  @override
  dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color.fromRGBO(17, 24, 39, 1),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<ImagePathCubit, String>(
                        builder: (context, imagePath) {
                          return CircleAvatar(
                            radius: 45,
                            backgroundImage: imagePath.isEmpty
                                ? const AssetImage('assets/images/profile.png')
                                : FileImage(
                                    File(
                                      imagePath,
                                    ),
                                  ) as ImageProvider,
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          popUpBottomSheet(context);
                        },
                        child: const Text(
                          'Change Photo',
                          style: TextStyle(
                            color: Color.fromRGBO(51, 102, 255, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          color: Color.fromRGBO(156, 163, 175, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomizedTextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bio',
                        style: TextStyle(
                          color: Color.fromRGBO(156, 163, 175, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomizedTextFormField(
                        controller: _bioController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your bio';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                          color: Color.fromRGBO(156, 163, 175, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomizedTextFormField(
                        controller: _addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'No.Handphone',
                        style: TextStyle(
                          color: Color.fromRGBO(156, 163, 175, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IntlPhoneField(
                        controller: _phoneController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        initialCountryCode: 'EG',
                        onChanged: (phone) {
                          _phoneNumber = phone;
                        },
                        pickerDialogStyle: PickerDialogStyle(
                          countryNameStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(17, 24, 39, 1),
                            fontWeight: FontWeight.w500,
                          ),
                          countryCodeStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(17, 24, 39, 1),
                            fontWeight: FontWeight.w500,
                          ),
                          searchFieldCursorColor:
                              const Color.fromRGBO(17, 24, 39, 1),
                        ),
                        dropdownTextStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(17, 24, 39, 1),
                          fontWeight: FontWeight.w500,
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(17, 24, 39, 1),
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          errorStyle: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(255, 71, 43, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(51, 102, 255, 1),
                              width: 1,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(156, 163, 175, 1),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    fontSize: 16,
                    onPressed: () {
                      if (_phoneNumber == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter a valid phone number',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }
                      if (_formKey.currentState!.validate() &&
                          _phoneNumber != null &&
                          _phoneNumber!.isValidNumber()) {
                        // TODO: Add function to save the data
                      }
                    },
                    text: 'Save',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void popUpBottomSheet(BuildContext context) async {
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
                  onTap: () async {
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
                        await ImagePicker()
                            .pickImage(source: ImageSource.camera)
                            .then(
                          (profileImage) {
                            if (profileImage != null) {
                              // save image to local device
                              BlocProvider.of<ImagePathCubit>(context)
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
                //! ----------------------------------------
                GestureDetector(
                  onTap: () async {
                    var permission = await Permission.photos.request();

                    if (permission.isDenied) {
                      log('denied');
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
                        await ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then(
                          (profileImage) {
                            if (profileImage != null) {
                              //TODO: save image to local device
                              BlocProvider.of<ImagePathCubit>(context)
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
}
