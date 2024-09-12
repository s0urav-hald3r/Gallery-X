import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:galleryx/models/image_model.dart';
import 'package:galleryx/views/full_image_view.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, this.image});

  final ImageModel? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (image != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullImageView(image: image!)),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.grey.shade200,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45, offset: Offset(2, 2), blurRadius: 5)
            ]),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
                child: Hero(
                  tag: image?.id ?? 'imageId',
                  child: Image.network(
                    image?.imageUrl ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/800px-Image_not_available.png',
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up_sharp,
                        size: 14.sp,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        '${image?.likes ?? 0}',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.remove_red_eye_sharp,
                        size: 14.sp,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        '${image?.views ?? 0}',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
