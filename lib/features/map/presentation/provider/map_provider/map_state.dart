part of 'map_provider.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapDataFetched extends MapState {}

class MapError extends MapState {
  final String message;
  const MapError(this.message);

  @override
  List<Object> get props => [message];
}