import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'flight.dart';

class FlightDataSource extends DataGridSource<Flight> {
  List<Flight> flights;

  FlightDataSource({@required this.flights});

  @override
  List<Flight> get dataSource => flights;

  @override
  Object getValue(Flight flight, String columnName) {
    switch (columnName) {
      case 'airlineAddress':
        return flight.airlineAddress.hex;
        break;
      case 'airlineName':
        return flight.airlineName;
        break;
      case 'flightIata':
        return flight.flightIata;
        break;
      case 'departureIata':
        return flight.departureIata;
        break;
      case 'arrivalIata':
        return flight.arrivalIata;
        break;
      case 'departureAirportName':
        return flight.departureAirportName;
        break;
      case 'arrivalAirportName':
        return flight.arrivalAirportName;
        break;
      case 'departureAirportString':
        return flight.departureAirportName + ' - ' + flight.departureIata;
        break;
      case 'arrivalAirportString':
        return flight.arrivalAirportName + ' - ' + flight.arrivalIata;
        break;
      case 'departureGate':
        return flight.departureGate;
        break;
      case 'arrivalGate':
        return flight.arrivalGate;
        break;
      case 'scheduledDeparture':
        return flight.scheduledDeparture;
        break;
      case 'scheduledArrival':
        return flight.scheduledArrival;
        break;
      case 'status':
        return flight.flightStatus.description();
        break;
      case 'registered':
        return flight.registered;
        break;
      default:
        {
          return flight.flightIata;
        }
    }
  }
}
