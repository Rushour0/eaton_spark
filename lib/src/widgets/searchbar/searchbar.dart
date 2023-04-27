import 'package:flutter/material.dart';
import 'dart:math' as math;

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
    required this.textController,
    required this.onChanged,
    required this.onSubmitted,
    required this.onToggle,
  });
  final TextEditingController textController;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final Function() onToggle;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
  }

  int toggle = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 375),
      height: 48.0,
      width: toggle == 0 ? 48 : screenWidth * 0.9,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: -10.0,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 375),
            top: 6.0,
            right: 7.0,
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: (toggle == 0) ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xffF2F3F7),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: AnimatedBuilder(
                  child: const Icon(
                    Icons.mic,
                    size: 20.0,
                  ),
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                      child: widget,
                    );
                  },
                  animation: _controller,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 375),
            left: (toggle == 0) ? 20.0 : 40.0,
            curve: Curves.easeOut,
            top: 11.0,
            child: AnimatedOpacity(
              opacity: (toggle == 0) ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: SizedBox(
                height: 23.0,
                width: 180.0,
                child: TextField(
                  controller: widget.textController,
                  cursorRadius: const Radius.circular(10.0),
                  cursorWidth: 2.0,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Search...',
                    labelStyle: const TextStyle(
                      color: Color(0xff5B5B5B),
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 375),
            left: 4,
            top: 4,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,
                icon: const Icon(
                  Icons.search,
                  size: 24.0,
                ),
                onPressed: () {
                  widget.onToggle();
                  setState(
                    () {
                      if (toggle == 0) {
                        toggle = 1;
                        _controller.forward();
                      } else {
                        toggle = 0;
                        widget.textController.clear();
                        _controller.reverse();
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
