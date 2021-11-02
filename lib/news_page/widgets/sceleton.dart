import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';





class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // padding: padding,
      physics: BouncingScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.white),
          child: SkeletonItem(
              child: Column(
                children: [
                  Row(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          shape: BoxShape.circle,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                              lines: 2,
                              spacing: 6,
                              lineStyle: SkeletonLineStyle(
                                randomLength: true,
                                height: 10,
                                borderRadius: BorderRadius.circular(8),
                                minLength: MediaQuery.of(context).size.width / 6,
                                maxLength: MediaQuery.of(context).size.width / 3,
                              )),
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 16,
                            width: 40,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 3,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: double.infinity,
                      minHeight: MediaQuery.of(context).size.height / 8,
                      maxHeight: MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          SkeletonAvatar(
                              style: SkeletonAvatarStyle(width: 20, height: 20)),
                          SizedBox(width: 8),
                          SkeletonAvatar(
                              style: SkeletonAvatarStyle(width: 20, height: 20)),
                        ],
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
