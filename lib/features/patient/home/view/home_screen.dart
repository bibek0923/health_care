import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/widgets/custom_input_textfield.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import '../../../../core/Const/app_images.dart';
import '../../../../core/app_routes/routes.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../controllers/home_controller.dart';
import '../widgets/doctor_container.dart';
import '../widgets/header.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController controller = Get.find();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          // bottomNavigationBar: Container(

          //   color: Colors.transparent,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.home),color: AppColors.blue,),
          //       IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.calendar_today),color: AppColors.blue,),
          //       IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.profile_circled),color: AppColors.blue,),
          //     ],
          //   ),
          // ),
          bottomNavigationBar: Obx(() {
  return BottomNavigationBar(
    currentIndex: controller.currentIndex.value,
    onTap: controller.onBottomNavTap,
    backgroundColor: AppColors.blue,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
    items: [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.calendar_today),
        label: 'Appointment',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        label: 'Profile',
      ),
    ],
  );
}),

          backgroundColor: AppColors.white,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              Get.toNamed(AppRoutes.AICHATSCREEN);
            },
            child: Image.asset(AppImages.ai),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(appSizes: appSizes, controller: controller),
              Expanded(
                child: Padding(
                  padding: appSizes.getCustomPadding(),
                  child: Column(
                    children: [
                      CustomInputTextField(
                        hintText: "Search here...",
                        prefixIcon: true,
                        borderRadius: 8,
                        textEditingController: controller.searchController,
                        onChange: (value) {
                          controller.searchText.value = value;
                        },
                      ),
                      Gap(8),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextWidget(
                          text: "Concerned Doctors:",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Gap(6),
                      Expanded(
                        child: StreamBuilder(
                          stream: controller.getDoctorsStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.blue,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: CustomTextWidget(
                                  text: "Something went wrong!",
                                  textColor: AppColors.red,
                                ),
                              );
                            } else if (snapshot.hasData) {
                              List<DoctorModel> doctors = snapshot.data!;
                              return Obx(() {
                                final query =
                                    controller.searchText.value.toLowerCase();
                                final filteredList =
                                    doctors.where((doctor) {
                                      return doctor.firstName
                                              .toLowerCase()
                                              .contains(query) ||
                                          doctor.lastName
                                              .toLowerCase()
                                              .contains(query);
                                    }).toList();

                                if (filteredList.isEmpty) {
                                  return Center(
                                    child: CustomTextWidget(
                                      text: "No doctors found",
                                      textColor: AppColors.blackish,
                                    ),
                                  );
                                }

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, index) {
                                    return DoctorContainer(
                                      doctor: filteredList[index],
                                    );
                                  },
                                  separatorBuilder: (_, __) => Gap(12),
                                );
                              });
                            }

                            return Center(
                              child: CustomTextWidget(
                                text: "No doctors found",
                                textColor: AppColors.blackish,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

