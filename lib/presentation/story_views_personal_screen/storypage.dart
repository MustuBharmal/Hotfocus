import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class StoryPage extends StatefulWidget {
  var stories;
  var pos;

  StoryPage(this.stories, this.pos, {Key? key}) : super(key: key);

  @override
  State<StoryPage>  createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentStoryIndex = 0;

  List<double> percentWatched = [];

  @override
  void initState() {
    super.initState();

    // initially, all stories haven't been watched yet
    /* for (int i = 0; i < myStories.length; i++) {
      percentWatched.add(0);
    }*/

    // _startWatching();
  }

  void _startWatching() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        // only add 0.01 as long as it's below 1
        if (percentWatched[currentStoryIndex] + 0.01 < 1) {
          percentWatched[currentStoryIndex] += 0.01;
        }
        // if adding 0.01 exceeds 1, set percentage to 1 and cancel timer
        else {
          percentWatched[currentStoryIndex] = 1;
          timer.cancel();

          /*// also go to next story as long as there are more stories to go through
          if (currentStoryIndex < myStories.length - 1) {
            currentStoryIndex++;
            // restart story timer
            _startWatching();
          }
          // if we are finishing the last story then return to homepage
          else {
            Navigator.pop(context);
          }*/
        }
      });
    });
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    // user taps on first half of screen
    if (dx < screenWidth / 2) {
      setState(() {
        // as long as this isnt the first story
        if (currentStoryIndex > 0) {
          // set previous and curent story watched percentage back to 0
          percentWatched[currentStoryIndex - 1] = 0;
          percentWatched[currentStoryIndex] = 0;

          // go to previous story
          currentStoryIndex--;
        }
      });
    }
    // user taps on second half of screen
    else {
      setState(() {
        // if there are more stories left
        /*  if (currentStoryIndex < myStories.length - 1) {
          // finish current story
          percentWatched[currentStoryIndex] = 1;
          // move to next story
          currentStoryIndex++;
        }
        // if user is on the last story, finish this story
        else {
          percentWatched[currentStoryIndex] = 1;
        }*/
      });
    }
  }

  /*@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _onTapDown(details),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: FadeInImage.assetNetwork(
                image: widget.stories['postUrl'],
                fit: BoxFit.cover,
                placeholder: "assets/images/hotfocus.png",
              ),
            ),

            // story
            */ /*   myStories[currentStoryIndex],

            // progress bar
            MyStoryBars(
              percentWatched: percentWatched,
            ),*/ /*
          ],
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _onTapDown(details),
      child: const AdMobWidget(),
    );
  }
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

    print('1');
    loadAd();
    // await MobileAds.instance.initialize();
    print('2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text('AdMob Widget')),
        body: Container(
          child: _bannerAd == null ? const Text('no ad') : AdWidget(ad: _bannerAd!),
        ));
  }

  BannerAd? _bannerAd;
  bool _isLoaded = false;

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
            print('$ad loaded.');
            // setState(() {
            //   _isLoaded = true;
            // });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            print('BannerAd failed to load: $err');
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
