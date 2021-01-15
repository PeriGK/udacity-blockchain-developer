import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dapp/components/flight_selected.dart';
import 'package:flutter_dapp/components/permissioned_button.dart';
import 'package:flutter_dapp/contract/contract_store.dart';
import 'package:flutter_dapp/data/actor.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'flight_table.dart';

class PassengerPage extends StatefulWidget {
  @override
  _PassengerPageState createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ContractStore>(context);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: Text(
              'Purchase Flight Insurance',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Observer(
              builder: (context) => store.registeredFlights.length < 1
                  ? Container(
                      child: Center(
                        child: Text("No flights are currently registered"),
                      ),
                    )
                  : FlightTable(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                flex: 2,
                child: ButtonBar(
                  alignment: MainAxisAlignment.start,
                  overflowDirection: VerticalDirection.down,
                  buttonPadding: EdgeInsets.all(8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PermissionedButton(
                        requiredRole: ActorType.Passenger,
                        action: () async {
                          // store.isTransactionPending = true;
                          // await store.setOperatingStatus();
                          // store.isTransactionPending = false;
                        },
                        buttonText: 'Get Flights',
                        disableCondition: store.isTransactionPending,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PermissionedButton(
                        requiredRole: ActorType.Passenger,
                        action: () async {
                          // store.isTransactionPending = true;
                          // await store.setOperatingStatus();
                          // store.isTransactionPending = false;
                        },
                        buttonText: 'Buy Insurance',
                        disableCondition: store.isTransactionPending,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rename Passenger',
                  ),
                  readOnly:
                      !(store.selectedActor.actorType == ActorType.Unassigned),
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                        text: store.selectedAirline.actorName,
                        selection: TextSelection.collapsed(
                            offset: store.selectedAirline.actorName.length)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      store.selectedActor.actorName = value;
                    });
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Amount',
                      labelText: 'Insurance Amount',
                      suffix: Text('ETH'),
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      double amount;
                      try {
                        amount = double.parse(value);
                      } catch (e) {
                        return 'Must be a number!';
                      }
                      if (amount > 1)
                        return "Cannot purchase more than 1 ETH insurance";
                      return "";
                    },
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlightSelected(),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
