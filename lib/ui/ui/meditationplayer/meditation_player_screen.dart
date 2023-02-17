import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/meditationplayer/common.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class MeditationPlayerScreen extends StatefulWidget {
  const MeditationPlayerScreen({Key? key, required this.meditationName})
      : super(key: key);
  final String meditationName;

  @override
  MeditationPlayerScreenState createState() => MeditationPlayerScreenState();
}

class MeditationPlayerScreenState extends State<MeditationPlayerScreen>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();
  bool soundOn = true;

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      if (kDebugMode) {
        print('A stream error occurred: $e');
      }
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(
          AudioSource.asset('assets/audio/${widget.meditationName}.mp3'));
    } catch (e) {
      if (kDebugMode) {
        print('Error loading audio source: $e');
      }
    }
    _player.play();
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: Stack(
        children: [
          const BgDecoration(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.white,
                        ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: Container(
                      height: 474.h,
                      width: 396.w,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/meditationimg.png'),
                        fit: BoxFit.fill,
                      )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/fullscreen.svg',
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Text(
                                meditationFullName(widget.meditationName),
                                style: AppTypography.mainStyle.copyWith(
                                  fontSize: 17.w,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: StreamBuilder<PositionData>(
                                stream: _positionDataStream,
                                builder: (context, snapshot) {
                                  final positionData = snapshot.data;
                                  return SeekBar(
                                    duration:
                                        positionData?.duration ?? Duration.zero,
                                    position:
                                        positionData?.position ?? Duration.zero,
                                    bufferedPosition:
                                        positionData?.bufferedPosition ??
                                            Duration.zero,
                                    onChangeEnd: _player.seek,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: ControlButtons(
                                _player,
                                soundOn: soundOn,
                                onSoundTap: () => setState(() {
                                  setState(() => soundOn = !soundOn);
                                  _player.setVolume(soundOn ? 1.0 : 0.0);
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String meditationFullName(String shortname) {
    switch (shortname) {
      case 'feelcalm':
        return 'How to be calm and relaxed...';
      case 'meditate':
        return 'Meditate and be mindful...';
      case 'sleepspace':
        return 'Enjoy your sleep...';
      default:
        return '';
    }
  }
}

class ControlButtons extends StatelessWidget {
  const ControlButtons(this.player,
      {Key? key, required this.soundOn, required this.onSoundTap})
      : super(key: key);
  final AudioPlayer player;
  final bool soundOn;
  final VoidCallback onSoundTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/images/share.svg',
        ),
        Row(
          children: [
            SvgPicture.asset('assets/images/prev.svg'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: StreamBuilder<PlayerState>(
                stream: player.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;
                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 64.0,
                      height: 64.0,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (playing != true) {
                    return IconButton(
                      icon: Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.white.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 6)
                            ]),
                        child: Center(
                          child: SvgPicture.asset('assets/images/play.svg'),
                        ),
                      ),
                      iconSize: 60.w,
                      onPressed: player.play,
                    );
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      icon: Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.white.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 6)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.pause,
                            size: 23.w,
                          ),
                        ),
                      ),
                      iconSize: 60.0.w,
                      onPressed: player.pause,
                    );
                  } else {
                    return IconButton(
                      icon: Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.white.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 6)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.replay,
                            size: 23.w,
                          ),
                        ),
                      ),
                      iconSize: 60.0.w,
                      onPressed: () => player.seek(Duration.zero),
                    );
                  }
                },
              ),
            ),
            SvgPicture.asset('assets/images/next.svg'),
          ],
        ),
        InkWell(
          onTap: onSoundTap,
          child: SvgPicture.asset(soundOn
              ? 'assets/images/volumeOn.svg'
              : 'assets/images/mute.svg'),
        ),
      ],
    );
  }
}
