import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sampleflutterdrawing/paint_controller.dart';
import 'package:sampleflutterdrawing/paint_history.dart';

/*
 * ペイント
 */
class Painter extends StatefulWidget {
  // ペイントコントローラ
  final PaintController paintController;

  Painter({required this.paintController})
      : super(key: ValueKey<PaintController>(paintController)) {
    assert(this.paintController != null);
  }

  @override
  _PainterState createState() => _PainterState();
}

/*
 * ペイント ステート
 */
class _PainterState extends State<Painter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // イベント監視
      child: GestureDetector(
        // カスタムペイント
        child: CustomPaint(
          willChange: true,

          // ペイント部分
          painter: _CustomPainter(
            widget.paintController.paintHistory,
            repaint: widget.paintController,
          ),
        ),

        // イベントリスナー
        onPanStart: _onPaintStart,
        onPanUpdate: _onPaintUpdate,
        onPanEnd: _onPaintEnd,
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  /*
   * 線ペイントの開始
   */
  void _onPaintStart(DragStartDetails start) {
    widget.paintController.paintHistory
        .addPaint(_getGlobalToLocalPosition(start.globalPosition));
    widget.paintController.notifyListeners();
  }

  /*
   * 線ペイント更新
   */
  void _onPaintUpdate(DragUpdateDetails update) {
    widget.paintController.paintHistory
        .updatePaint(_getGlobalToLocalPosition(update.globalPosition));
    widget.paintController.notifyListeners();
  }

  /*
   * 線ペイントの終了
   */
  void _onPaintEnd(DragEndDetails end) {
    widget.paintController.paintHistory.endPaint();
    widget.paintController.notifyListeners();
  }

  /*
   * ローカルのオフセットへ変換
   */
  Offset _getGlobalToLocalPosition(Offset global) {
    return (context.findRenderObject() as RenderBox).globalToLocal(global);
  }
}

/*
 * カスタムペイント
 */
class _CustomPainter extends CustomPainter {
  final PaintHistory _paintHistory;

  _CustomPainter(this._paintHistory, {Listenable? repaint})
      : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _paintHistory.draw(canvas, size);
  }

  @override
  bool shouldRepaint(_CustomPainter oldDelegate) => true;
}
