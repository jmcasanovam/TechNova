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

  @override
  void initState() {
    super.initState();

    if (widget.tipoPaso == TipoPaso.video) {
      _videoPlayerController = VideoPlayerController.network(widget.contenido)
        ..initialize().then((_) {
          setState(() {}); // Actualiza el estado cuando el video está listo
        }).catchError((error) {
          print("Error al inicializar el video: $error");
        })
        ..addListener(() {
          if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
            // El video ha terminado
            setState(() {
              _isPlaying = false;
            });
          }
        });
          
    } else if (widget.tipoPaso == TipoPaso.audio) {
      _audioPlayer = AudioPlayer();
      _audioPlayer.setUrl(widget.contenido).catchError((error) {
        print("Error al cargar el audio: $error");
      });

      // Escuchar cambios en el estado de reproducción
      _audioPlayer.playerStateStream.listen((playerState) {
        setState(() {
          _isPlaying = playerState.playing; // Actualizar el estado de _isPlaying
        });
        // Si el audio ha terminado, cambiar el estado a pausa
        if (playerState.processingState == ProcessingState.completed) {
          setState(() {
            _isPlaying = false;
          });
        }
      });
    }
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
    switch (widget.tipoPaso) {
      case TipoPaso.texto:
        return Text(
          widget.contenido,
          style: const TextStyle(fontSize: 18),
        );

      case TipoPaso.imagen:
        return Image.network(
          widget.contenido,
          width: screenWidth * 0.8,
          height: screenHeight * 0.4,
          fit: BoxFit.cover,
        );

      case TipoPaso.video:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _videoPlayerController.value.isInitialized
                ? SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.4,
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  )
                : const CircularProgressIndicator(),
            IconButton(
              icon: Icon(
                _videoPlayerController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: _togglePlayPause,
              iconSize: 48,
            ),
          ],
        );

      case TipoPaso.audio:
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
