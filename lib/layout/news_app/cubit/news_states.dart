abstract class NewsStates {}

class NewsIninialState extends NewsStates{}

class ChangeBottomNav extends NewsStates{}

class GetNewsAppBusinessDataSucced extends NewsStates{}

class LoadingBusinessAppData extends NewsStates{}

class GetNewsAppBusinessDataError extends NewsStates{
  late String error;
  GetNewsAppBusinessDataError(error);
}

class GetNewsAppSportsDataSucced extends NewsStates{}

class LoadingSportsDAppData extends NewsStates{}

class GetNewsAppSportsDDataError extends NewsStates{
  late String error;
  GetNewsAppSportsDDataError(error);
}

class GetNewsAppScienceDataSucced extends NewsStates{}

class LoadingSienceDAppData extends NewsStates{}

class GetNewsAppScienceDDataError extends NewsStates{
  late String error;
  GetNewsAppScienceDDataError(error);
}

class GetSearchDataSucced extends NewsStates{}

class LoadingSearchAppData extends NewsStates{}

class GetSearchDataError extends NewsStates{
  late String error;
  GetSearchDataError(error);
}

  class ChangeBetweenModes extends NewsStates{}
