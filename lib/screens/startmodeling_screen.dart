import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class StartModelingScreen extends StatelessWidget {
  const StartModelingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Modeling'),
        backgroundColor: const Color(0xFF586C7C),
      ),
      body: Center(
        child: Cube(
          onSceneCreated: (Scene scene) {
            scene.world.add(Object(
              scale: Vector3(8.0, 8.0, 8.0),
              fileName: 'assets/3d/cube.obj',
            ));
            scene.camera.zoom = 10;
          },
        ),
      ),
    );
  }
}
