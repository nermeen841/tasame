import 'package:api_request/api_request.dart';
import 'package:zat/presentation/screens/home/model/all_consultant.dart';

class SearchActions extends ApiRequestAction<AllConsultantModel> {
  final String keyword;
  final int gender;
  final int rate;
  final int languageID;

  SearchActions(this.keyword, this.gender, this.languageID, this.rate);

  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path =>
      "/authsearch-by-tutor?keyword=$keyword&gender=$gender&language_id=$languageID&rate=$rate&limit=1000&offset=0";

  @override
  ResponseBuilder<AllConsultantModel> get responseBuilder =>
      (json) => AllConsultantModel.fromJson(json);

  @override
  bool get authRequired => true;
}
