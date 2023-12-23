import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  CustomCard(
      {Key? key,
      required this.size,
      required this.icon,
      required this.title,
      required this.statusOn,
      required this.statusOff,
      required this.isChecked,
      required this.toggle,
      required this.onLongPress})
      : super(key: key);

  final Size size;
  final Icon icon;
  final String title;
  final String statusOn;
  final String statusOff;
  final VoidCallback onLongPress;
  bool isChecked;
  Function toggle;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    _animation = Tween<Alignment>(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
        reverseCurve: Curves.easeInBack,
      ),
    );

    if (widget.isChecked) {
      _animationController.value = 1.0;
    } else {
      _animationController.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(covariant CustomCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isChecked) {
      _animationController.animateTo(1.0);
    } else {
      _animationController.animateTo(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressUp: () {
        
        widget.onLongPress();
      
      },
      onTap: () {
        setState(() {
          widget.toggle();
          widget.isChecked = !widget.isChecked;
          if (_animationController.isCompleted) {
            _animationController.animateTo(20);
          } else {
            _animationController.animateTo(0);
          }
        });
      },
      child: Container(
        height: 150,
        width: widget.size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue[50],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.icon,
                  widget.title != "LEAKS"
                      ? AnimatedBuilder(
                          animation: _animationController,
                          builder: (animation, child) {
                            return Container(
                              height: 40,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade50,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 8,
                                    offset: Offset(3, 3),
                                  ),
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    offset: Offset(-3, -3),
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: _animation.value,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 1),
                                  decoration: BoxDecoration(
                                    color: widget.isChecked
                                        ? Color(0xFF47f03e)
                                        : Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF07062e),
                ),
              ),
              Text(
                widget.isChecked ? widget.statusOn : widget.statusOff,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.isChecked
                      ? Color(0xFF47f03e)
                      : Colors.grey.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
