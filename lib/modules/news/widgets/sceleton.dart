import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

/// Виджет превью загрузки NewsScreen
class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    const SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        shape: BoxShape.circle,
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                          lines: 2,
                          spacing: 6,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 10.0,
                            borderRadius: BorderRadius.circular(8.0),
                            minLength: MediaQuery.of(context).size.width / 6,
                            maxLength: MediaQuery.of(context).size.width / 3,
                          ),
                        ),
                      ),
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 16.0,
                          width: 40.0,
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lines: 1,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10.0,
                      borderRadius: BorderRadius.circular(8.0),
                      minLength: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lines: 3,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10.0,
                      borderRadius: BorderRadius.circular(8.0),
                      minLength: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: double.infinity,
                    minHeight: MediaQuery.of(context).size.height / 8,
                    maxHeight: MediaQuery.of(context).size.height / 3,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 8.0),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 20.0, height: 20.0),
                        ),
                        const SizedBox(width: 8.0),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 20.0, height: 20.0),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
