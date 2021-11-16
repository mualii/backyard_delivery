import 'package:backyard_delivery/models/orderDetails.dart';

abstract class AvailibaleDeliveryState {}
class AvailibaleDeliveryInitialState extends AvailibaleDeliveryState{}
class AvailibaleDeliveryLoadingState extends AvailibaleDeliveryState{}
class AvailibaleDeliveryLoadedState extends AvailibaleDeliveryState{}
class AvailibaleDeliveryErrorState extends AvailibaleDeliveryState{}
class DetailsLoadingState extends AvailibaleDeliveryState{}
class DetailsLoadedState extends AvailibaleDeliveryState{
OrderDetails? orders;
DetailsLoadedState(this.orders);
}
class DetailsErrorState extends AvailibaleDeliveryState{}
class AvailibaleDeliveryLoadingMoreState extends AvailibaleDeliveryState{}