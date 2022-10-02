import 'package:ddd_riverpod/auth/shared/provider.dart';
import 'package:ddd_riverpod/core/shared/widgets/render_local_image.dart';
import 'package:ddd_riverpod/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authNotifierProvider,
      (previous, state) {
        state.maybeWhen(
          orElse: () {},
          failure: (failure) {
            debugPrint('Show error dialog with error: ${failure.toString()}');
          },
        );
      },
    );

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.2),
              child: Column(
                children: [
                  RenderLocalImage(
                    imagePath: Assets.logo.path,
                    height: 150,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'DDD RiverPod\n Messenger',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.green,
                      ),
                    ),
                    child: const Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      ref.read(authNotifierProvider.notifier).signWithGoogle();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
