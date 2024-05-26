import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/ui/cards/base_movie_card.dart';
import 'package:we_work_flutter_challenge/ui/util/custom_shape_clipper.dart';
import 'package:locale_names/locale_names.dart';

class NowPlayingMovieCard extends BaseMovieCard {
  const NowPlayingMovieCard({super.key, required super.movie});

  String getLanguageFullName(String languageCode) {
  try {
    languageCode = languageCode.toLowerCase();
    final data = DisplayNames.tables['en'] as Map<String, String>?;
    if (data != null && data.containsKey(languageCode)) {
      return data[languageCode] ?? 'Unknown';
    }
    return 'Unknown';
  } catch (e) {
    return 'Unknown Language';
  }
}

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ClipPath(
          clipper: CustomShapeClipper(
              topHeight: 40, bottomHeight: 60, topBarOffset: -20),
          child: buildImage(context),
        ),
        Column(
          children: [
            buildTopBar(textTheme),
            const Spacer(),
            ClipPath(
              clipper: CustomShapeClipper(
                  topHeight: 40, bottomHeight: 60, topBarOffset: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.8)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: width / 3),
                          const Icon(Icons.location_on_outlined,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 5),
                          Text(
                            getLanguageFullName(movie.originalLanguage),
                            style: textTheme.bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        movie.title,
                        maxLines: 1,
                        style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month,
                              size: 16, color: Colors.white),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 35,
                            child: Text(
                              movie.overview,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${movie.voteCount} Votes',
                        style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
