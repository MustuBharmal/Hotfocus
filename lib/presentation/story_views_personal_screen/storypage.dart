import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_player/video_player.dart';
import 'models/story_views_personal_model.dart';

enum MediaType {
  image,
  video,
}

class StoryPage extends StatefulWidget {
  final List<Story> stories;

  const StoryPage(this.stories, {Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;
  VideoPlayerController? _videoController;
  int currentStoryIndex = 0;

  List<double> percentWatched = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);
    final Story firstStory = widget.stories.first;

    _loadStory(story: firstStory, animateToPage: false);
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (currentStoryIndex + 1 < widget.stories.length) {
            currentStoryIndex += 1;
            _loadStory(story: widget.stories[currentStoryIndex]);
          } else {
            Navigator.of(context).pop();
            // _loadStory(story: widget.stories[_currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  void _loadStory({required Story story, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();
    switch (story.media) {
      case 'image':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'video':
        _videoController = null;
        _videoController?.dispose();
        final uri = Uri.parse(story.postUrl);
        _videoController = VideoPlayerController.contentUri(uri)
          ..initialize().then((_) {
            setState(() {});
            if (_videoController!.value.isInitialized) {
              _animController.duration = _videoController!.value.duration;
              _videoController!.play();
              _animController.forward();
            }
          });
        break;
    }

    if (animateToPage) {
      _pageController.animateToPage(
        currentStoryIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // void _startWatching() {
  //   Timer.periodic(const Duration(milliseconds: 10), (timer) {
  //     setState(() {
  //       // only add 0.01 as long as it's below 1
  //       if (percentWatched[currentStoryIndex] + 0.01 < 1) {
  //         percentWatched[currentStoryIndex] += 0.01;
  //       }
  //       // if adding 0.01 exceeds 1, set percentage to 1 and cancel timer
  //       else {
  //         percentWatched[currentStoryIndex] = 1;
  //         timer.cancel();
  //
  //         /*// also go to next story as long as there are more stories to go through
  //         if (currentStoryIndex < myStories.length - 1) {
  //           currentStoryIndex++;
  //           // restart story timer
  //           _startWatching();
  //         }
  //         // if we are finishing the last story then return to homepage
  //         else {
  //           Navigator.pop(context);
  //         }*/
  //       }
  //     });
  //   });
  // }
  // void _loadStories(int index) {
  //   setState(() {
  //     currentStoryIndex = index;
  //     _loadStory(story: widget.stories[currentStoryIndex]);
  //   });
  // }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (currentStoryIndex - 1 >= 0) {
          currentStoryIndex -= 1;
          _loadStory(story: widget.stories[currentStoryIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (currentStoryIndex + 1 < widget.stories.length) {
          currentStoryIndex += 1;
          _loadStory(story: widget.stories[currentStoryIndex]);
        } else {
          Navigator.of(context).pop();
          // _currentIndex = 0;
          _loadStory(story: widget.stories[currentStoryIndex]);
        }
      });
    } else {
      if (story.media == MediaType.video.toString()) {
        if (_videoController!.value.isPlaying) {
          _videoController!.pause();
          _animController.stop();
        } else {
          _videoController!.play();
          _animController.forward();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[currentStoryIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, story),
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swiped right
            setState(() {
              if (currentStoryIndex - 1 >= 0) {
                currentStoryIndex -= 1;
                _loadStory(story: widget.stories[currentStoryIndex]);
              }
            });
          } else if (details.primaryVelocity! < 0) {
            // Swiped left
            setState(() {
              if (currentStoryIndex + 1 < widget.stories.length) {
                currentStoryIndex += 1;
                _loadStory(story: widget.stories[currentStoryIndex]);
              } else {
                Navigator.of(context).pop();
                _loadStory(story: widget.stories[currentStoryIndex]);
              }
            });
          }
        },
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.stories.length,
              itemBuilder: (context, i) {
                final Story story = widget.stories[i];
                switch (story.media) {
                  case 'image':
                    return CachedNetworkImage(
                      imageUrl: story.postUrl,
                      fit: BoxFit.cover,
                    );
                  case 'video':
                    if (_videoController != null &&
                        _videoController!.value.isInitialized) {
                      return FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController!.value.size.width,
                          height: _videoController!.value.size.height,
                          child: VideoPlayer(_videoController!),
                        ),
                      );
                    }
                }
                return const SizedBox.shrink();
              },
            ),
            Positioned(
              top: 40.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: widget.stories
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            AnimatedBar(
                              animController: _animController,
                              position: i,
                              currentIndex: currentStoryIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: CachedNetworkImageProvider(
                           story.profImage,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            story.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _onTapDown(details),
      child: const AdMobWidget(),
    );
  }*/
}

class AdMobWidget extends StatefulWidget {
  const AdMobWidget({super.key});

  @override
  State<AdMobWidget> createState() => _AdMobWidgetState();
}

class _AdMobWidgetState extends State<AdMobWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadAd();
    // await MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('AdMob Widget')),
      body: Container(
        child:
            _bannerAd == null ? const Text('no ad') : AdWidget(ad: _bannerAd!),
      ),
    );
  }

  BannerAd? _bannerAd;

  // bool _isLoaded = false;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = 'ca-app-pub-5187592771058994/3388909967';

  // final adUnitId = 'ca-app-pub-3940256099942544/1033173712';
  // final adUnitId = 'ca-app-pub-3940256099942544/6300978111';

  void loadAd() {
    try {
      _bannerAd = BannerAd(
        adUnitId: adUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            // print('$ad loaded.');
            // setState(() {
            //   _isLoaded = true;
            // });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            // print('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },
        ),
      )..load();
      // return Future.delayed(
      //     const Duration(seconds: 1), () => print('Large Latte'));
    } catch (e) {
      print(e);
      // return Future.delayed(
      //     const Duration(seconds: 0), () => print('Large Latte'));
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    super.key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
