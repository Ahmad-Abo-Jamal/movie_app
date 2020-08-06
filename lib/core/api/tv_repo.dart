import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/core/models/tv_model.dart';

abstract class TvRepo {
  Future<TvDetails> getTvById(int id);
  Future<TvList> getNextTvPage(String criteria, int page);
  Future<TvList> getTrending(int page, String dw);
  Future<TvList> getSimilarTv(int id);
}
