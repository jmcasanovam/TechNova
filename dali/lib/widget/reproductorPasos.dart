import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';

enum TipoPaso { texto, imagen, video, audio }

class ReproductorPasos extends StatefulWidget {
  final TipoPaso tipoPaso;
  final String contenido; // URL o texto en función del tipo de paso

  const ReproductorPasos({
    super.key,
    required this.tipoPaso,
    required this.contenido,
  });

  @override
  State<ReproductorPasos> createState() => _ReproductorPasosState();
}

class _ReproductorPasosState extends State<ReproductorPasos> {
  late VideoPlayerController _videoPlayerController;
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isVideoInitialized = false;
  bool _isAudioInitialized = false;
  bool _isError = false;  // Para manejar el error de carga

  @override
  void initState() {
    super.initState();

    if (widget.tipoPaso == TipoPaso.video) {
      _initializeVideo();
    } else if (widget.tipoPaso == TipoPaso.audio) {
      _initializeAudio();
    }
  }

  // Inicializar video
  void _initializeVideo() {
    _videoPlayerController = VideoPlayerController.network(widget.contenido)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true; // El video está listo para reproducirse
        });
      }).catchError((error) {
        setState(() {
          _isError = true;
        });
        print("Error al inicializar el video: $error");
      });

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
        setState(() {
          _isPlaying = false; // El video ha terminado
        });
      }
    });
  }

  // Inicializar audio
  void _initializeAudio() async {
    _audioPlayer = AudioPlayer();
    try {
      await _audioPlayer.setUrl(widget.contenido);
      setState(() {
        _isAudioInitialized = true; // El audio está listo para reproducirse
      });
    } catch (error) {
      setState(() {
        _isError = true;
      });
      print("Error al cargar el audio: $error");
    }

    _audioPlayer.playerStateStream.listen((playerState) {
      setState(() {
        _isPlaying = playerState.playing;
      });

      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    if (widget.tipoPaso == TipoPaso.video) {
      _videoPlayerController.dispose();
    } else if (widget.tipoPaso == TipoPaso.audio) {
      _audioPlayer.dispose();
    }
    super.dispose();
  }

  void _togglePlayPause() async {
    if (widget.tipoPaso == TipoPaso.video) {
      setState(() {
        if (_videoPlayerController.value.isPlaying) {
          _videoPlayerController.pause();
        } else {
          _videoPlayerController.play();
        }
        _isPlaying = !_isPlaying;
      });
    } else if (widget.tipoPaso == TipoPaso.audio) {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(10),
      child: _buildContent(screenWidth, screenHeight),
    );
  }

  Widget _buildContent(double screenWidth, double screenHeight) {
    if (_isError) {
      return Center(
        child: Text(
          "Error al cargar el contenido",
          style: TextStyle(fontFamily: 'Roboto', color: Colors.red, fontSize: screenWidth * 0.05),
        ),
      );
    }

    switch (widget.tipoPaso) {
      case TipoPaso.texto:
        return Text(
          widget.contenido,
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.02, fontFamily: 'Roboto', ),
        );

      case TipoPaso.imagen:
        return Image.network(
          widget.contenido,
          width: screenWidth * 0.8,
          height: screenHeight * 0.4,
          fit: BoxFit.contain,
        );

      case TipoPaso.video:
        if (!_isVideoInitialized) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.25,
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
            ),
            IconButton(
              icon: Icon(
                _videoPlayerController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: _togglePlayPause,
              iconSize: screenHeight * 0.08,
            ),
          ],
        );

      case TipoPaso.audio:
        if (!_isAudioInitialized) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.audiotrack,
              size: 100,
              color: Colors.blueAccent,
            ),
            IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: _togglePlayPause,
              iconSize: 48,
            ),
          ],
        );

      default:
        return const Text('Tipo de paso no soportado');
    }
  }
}
