import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/helper/image_uploader.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/core/widgets/custom_text_form_field.dart';
import 'package:se7ety/core/widgets/dialogs.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/feature/auth/data/models/specializations.dart';
import 'package:se7ety/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/feature/auth/presentation/cubit/auth_state.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userID;

  // Database , Cloud

  //* to upload image to firestore
  // 1) upload image to storage (Firebase Storage / Supabase storage / Cloudinary)
  // 2) get image url from storage
  // 3) update image url in firestore

  // doctors/729348014014912.png

  // uploadImageToFirebaseStorage(File image, String imageName) async {
  //   try {
  //     Reference ref = FirebaseStorage.instanceFor(
  //       bucket: 'gs://easy-doc-e56b4.appspot.com',
  //     ).ref().child('doctor/${FirebaseAuth.instance.currentUser!.uid}');

  //     SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  //     await ref.putFile(image, metadata);
  //     String url = await ref.getDownloadURL();
  //     log(url);
  //     return url;
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('إكمال عملية التسجيل')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          log('Auth State: $state');
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            pop(context);
            //  navigate to home screen
            log('Navigate to doctor home screen');
          } else if (state is AuthErrorState) {
            pop(context);
            showMyDialog(context, state.error);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await _pickImage();
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.whiteColor,
                            backgroundImage: (_imagePath != null)
                                ? FileImage(File(_imagePath!))
                                : AssetImage(AppImages.docPlaceholder),
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.whiteColor,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Text(
                        'التخصص',
                        style: TextStyles.body.copyWith(
                          color: AppColors.darkColor,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  // التخصص---------------
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton<String?>(
                      isExpanded: true,
                      iconEnabledColor: AppColors.primaryColor,
                      underline: const SizedBox(),
                      hint: Text(
                        'اختر التخصص',
                        style: TextStyles.body.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      icon: const Icon(Icons.expand_circle_down_outlined),
                      value: cubit.specialization,
                      onChanged: (String? newValue) {
                        setState(() {
                          cubit.specialization = newValue;
                        });
                      },
                      items: [
                        for (var specialization in specializations)
                          DropdownMenuItem(
                            value: specialization,
                            child: Text(specialization),
                          ),
                      ],
                    ),
                  ),
                  const Gap(15),
                  Text(
                    'نبذة تعريفية',
                    style: TextStyles.body.copyWith(color: AppColors.darkColor),
                  ),
                  const Gap(10),
                  CustomTextFormField(
                    controller: cubit.bioController,
                    maxLines: 4,
                    hintText:
                        'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة...',

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل النبذة التعريفية';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const Gap(15),
                  Divider(),
                  const Gap(15),
                  Text(
                    'عنوان العيادة',
                    style: TextStyles.body.copyWith(color: AppColors.darkColor),
                  ),
                  const Gap(10),
                  CustomTextFormField(
                    controller: cubit.addressController,
                    hintText: '5 شارع مصدق - الدقي - الجيزة',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل عنوان العيادة';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const Gap(15),
                  _workHours(cubit),
                  const Gap(15),
                  _phoneNumbers(cubit),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: MainButton(
              onPressed: () async {
                if (cubit.formKey.currentState!.validate()) {
                  if (file != null) {
                    cubit.imageUrl = await uploadImageToCloudinary(file!) ?? '';

                    cubit.updateDoctorData();
                  } else {
                    showMyDialog(
                      context,
                      'من فضلك قم باختيار صورة الصفحة الشخصية',
                    );
                  }
                }
              },
              text: "التسجيل",
            ),
          ),
        ),
      ),
    );
  }

  Column _workHours(AuthCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'ساعات العمل من',
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ),
            const Gap(15),
            Expanded(
              child: Text(
                'الي',
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            // ---------- Start Time ----------------
            Expanded(
              child: CustomTextFormField(
                readOnly: true,
                controller: cubit.openHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                onTap: () async {
                  await showStartTimePicker(cubit);
                },
                suffixIcon: const Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.primaryColor,
                ),

                hintText: '00:00',
              ),
            ),
            const SizedBox(width: 10),

            // ---------- End Time ----------------
            Expanded(
              child: CustomTextFormField(
                readOnly: true,
                controller: cubit.closeHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                onTap: () async {
                  await showEndTimePicker(cubit);
                },
                suffixIcon: const Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.primaryColor,
                ),

                hintText: '00:00',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _phoneNumbers(AuthCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'رقم الهاتف 1',
          style: TextStyles.body.copyWith(color: AppColors.darkColor),
        ),
        const Gap(10),
        CustomTextFormField(
          controller: cubit.phone1Controller,
          keyboardType: TextInputType.number,
          hintText: '+20xxxxxxxxxx',

          validator: (value) {
            if (value!.isEmpty) {
              return 'من فضلك ادخل الرقم';
            } else {
              return null;
            }
          },
        ),
        const Gap(15),
        Text(
          'رقم الهاتف 2 (اختياري)',
          style: TextStyles.body.copyWith(color: AppColors.darkColor),
        ),
        const Gap(10),
        CustomTextFormField(
          controller: cubit.phone2Controller,
          keyboardType: TextInputType.number,
          hintText: '+20xxxxxxxxxx',
        ),
      ],
    );
  }

  Future<void> showStartTimePicker(AuthCubit cubit) async {
    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
      cubit.openHourController.text = startTimePicked.hour.toString();
    }
  }

  Future<void> showEndTimePicker(AuthCubit cubit) async {
    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 15)),
      ),
    );

    if (endTimePicked != null) {
      cubit.closeHourController.text = endTimePicked.hour.toString();
    }
  }
}
