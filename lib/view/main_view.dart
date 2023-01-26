import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapd722_pay_calculator/framework.dart';

import '../view_model/main_view_model.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends BaseMVVMState<MainView, MainViewModel> {
  @override
  Widget buildChild(ctx, MainViewModel vm) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Form(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: "Number of hours",
                    border: const OutlineInputBorder(),
                    hintText: vm.numbersOfHour.toString(),
                  ),
                  validator: (v) => vm.validateNumbersOfHour(v),
                  onChanged: vm.onChangeNumbersOfHour,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Hours Rate",
                    border: const OutlineInputBorder(),
                    hintText: vm.hourlyRate.toString(),
                  ),
                  validator: (t) {
                    return vm.validateHourlyRate(t);
                  },
                  onChanged: vm.onChangeHourlyRate,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9]+.?[0-9]*'))
                  ],
                ),
              ),
              Container(
                color: Colors.blue.shade50,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 12,
                child: TextButton(
                  style: TextButtonTheme.of(ctx).style,
                  onPressed: vm.calculate,
                  child: const Text("Calculate"),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Visibility(
          visible: vm.calculated,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: const Text(
              "Report",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Visibility(
          visible: vm.calculated,
          child: Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Spacer(),
                  Column(
                    children: const [
                      Expanded(
                        child:
                            Text("Regular Pay", style: TextStyle(fontSize: 20)),
                      ),
                      Expanded(
                        child: Text("Overtime Pay",
                            style: TextStyle(fontSize: 20)),
                      ),
                      Expanded(
                        child:
                            Text("Total Pay", style: TextStyle(fontSize: 20)),
                      ),
                      Expanded(
                        child: Text("Tax", style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Expanded(
                          child: Text(vm.regularPay.toString(),
                              style: const TextStyle(fontSize: 20))),
                      Expanded(
                          child: Text(vm.overtimePay.toString(),
                              style: const TextStyle(fontSize: 20))),
                      Expanded(
                          child: Text(
                              (vm.regularPay + vm.overtimePay).toString(),
                              style: const TextStyle(fontSize: 20))),
                      Expanded(
                        child: Text(vm.tax.toString(),
                            style: const TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          child: Container(
            color: Colors.blue.shade50,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 12,
            alignment: Alignment.center,
            child: Text(
              vm.getAbout(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        )
      ],
    );
  }

  @override
  MainViewModel buildViewModel() {
    return MainViewModel();
  }
}
