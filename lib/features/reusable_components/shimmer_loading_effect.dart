import 'package:flutter/material.dart';

class ShimmerLoadingEffect extends StatefulWidget{
  final Widget child;
  final bool startAnim;
  ShimmerLoadingEffect({Key? key, required this.child, required this.startAnim}) : super(key: key ?? UniqueKey());

  @override
  State<ShimmerLoadingEffect> createState() => _ShimmerLoadingEffectState();
}

class _ShimmerLoadingEffectState extends State<ShimmerLoadingEffect> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Color?> colorTween;
  late final Animation<Color?> colorTweenReverse;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 1300));
    colorTween = ColorTween(begin: Colors.white, end: Colors.grey.shade400).animate(animationController);
    colorTweenReverse = ColorTween(begin: Colors.grey.shade400, end: Colors.white).animate(animationController);

    if(widget.startAnim){
      animationController.forward();
    }

    animationController.addListener(() {
      if(widget.startAnim){
        if(animationController.isCompleted){
          animationController.reverse();
        }else if(animationController.isDismissed){
          animationController.forward();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.startAnim,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            if(!widget.startAnim){
              return child!;
            }

            return ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return LinearGradient(
                    colors: [colorTween.value!,colorTweenReverse.value!]
                ).createShader(bounds);
              },

              child: child,
            );
          },
          child: widget.child

      ),
    );
  }
}
