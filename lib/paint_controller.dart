/*
 * ペイントコントローラ
 */
import 'package:flutter/widgets.dart';
import 'package:sampleflutterdrawing/paint_history.dart';

class PaintController extends ChangeNotifier {
  // ペイント履歴
  PaintHistory _paintHistory = PaintHistory();

  PaintHistory get paintHistory => _paintHistory;

  // 線の色
  Color _drawColor = Color.fromARGB(255, 0, 0, 0);

  // 線幅
  double _thickness = 5.0;

  // 背景色
  Color _backgroundColor = Color.fromARGB(255, 255, 255, 255);

  /*
   * コンストラクタ
   */
  PaintController() : super() {
    // ペイント設定
    Paint paint = Paint();
    paint.color = _drawColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = _thickness;
    _paintHistory.currentPaint = paint;
    _paintHistory.backgroundColor = _backgroundColor;
  }

  /*
   * undo実行
   */
  void undo() {
    _paintHistory.undo();
    notifyListeners();
  }

  /*
   * redo実行
   */
  void redo() {
    _paintHistory.redo();
    notifyListeners();
  }

  /*
   * undo可能か
   */
  bool get canUndo => _paintHistory.canUndo();

  /*
   * redo可能か
   */
  bool get canRedo => _paintHistory.canRedo();

  /*
   * リスナー実行
   */
  void notifyListeners() {
    notifyListeners();
  }

  /*
   * クリア
   */
  void clear() {
    _paintHistory.clear();
    notifyListeners();
  }
}
