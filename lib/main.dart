import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:galleryx/controllers/image_controller.dart';
import 'package:galleryx/views/gallery_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.lazyPut(() => ImageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              splashFactory: NoSplash.splashFactory,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.orange,
                elevation: 5,
                centerTitle: true,
                titleTextStyle:
                    GoogleFonts.poppins(fontSize: 20.sp, color: Colors.black87),
              ),
              primaryColor: Colors.orange,
              scaffoldBackgroundColor: Colors.grey.shade50,
            ),
            home: GalleryView(),
          );
        });
  }
}
