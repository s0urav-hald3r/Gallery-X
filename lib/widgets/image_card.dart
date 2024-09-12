import 'package:flutter/material.dart';
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
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45, offset: Offset(2, 2), blurRadius: 5)
            ]),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.thumb_up_sharp,
                        size: 14,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${image?.likes ?? 0}',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.remove_red_eye_sharp,
                        size: 14,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${image?.views ?? 0}',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
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
