import 'package:flutter/material.dart';
import 'package:imc_app/classes/imc.dart';
import 'package:imc_app/repositories/imc_repo.dart';

class CreateIMCPage extends StatefulWidget {
  const CreateIMCPage({super.key});

  @override
  State<CreateIMCPage> createState() => _CreateIMCPageState();
}

class _CreateIMCPageState extends State<CreateIMCPage> {
  var imcHeightController = TextEditingController(text: "");
  var imcWeightController = TextEditingController(text: "");
  var imcRepo = IMCRepository();
  // ignore: non_constant_identifier_names
  var _IMCs = <IMC>[];

  Widget imcCreationDialog(BuildContext bc) {
    return AlertDialog(
      title: const Text("Calculate new IMC"),
      content: Column(
        children: [
          TextField(
            controller: imcWeightController,
            decoration: const InputDecoration(labelText: "Weight"),
          ),
          TextField(
            controller: imcHeightController,
            decoration: const InputDecoration(labelText: "Height"),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              cleanControllers();
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
        TextButton(
            onPressed: onCalculateNewImc, child: const Icon(Icons.check)),
      ],
    );
  }

  void onCalculateNewImc() {
    var parsedHeight = double.tryParse(imcHeightController.text);
    print(parsedHeight);
    var parsedWeight = double.tryParse(imcWeightController.text);
    print(parsedWeight);
    if (parsedHeight != null && parsedWeight != null) {
      var imc = IMC(parsedHeight, parsedWeight);
      imc.calculateIMC();
      imcRepo.saveNew(imc);
      cleanControllers();
      retrieveIMCs();
      setState(() {});
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext bc) {
            return const AlertDialog(
                title: Text("Error"),
                content: Text("Not possible to parse values"));
          });
    }
  }

  void cleanControllers() {
    imcHeightController.text = "";
    imcWeightController.text = "";
  }

  void retrieveIMCs() {
    _IMCs = imcRepo.listAll();
  }

  @override
  void initState() {
    super.initState();
    _IMCs = imcRepo.listAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('IMC App'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: imcCreationDialog);
          },
          tooltip: "Calculate new IMC",
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _IMCs.isEmpty
              ? const Center(
                  child: Text("No IMC's calculated yet!"),
                )
              : ListView.builder(
                  itemBuilder: (BuildContext bc, int index) {
                    var imc = _IMCs[index];
                    return Dismissible(
                      key: Key(imc.id),
                      child: ListTile(
                          title:
                              Text("IMC value: ${imc.imc.toStringAsFixed(2)}"),
                          subtitle:
                              Text("Classification: ${imc.classification}"),
                          trailing: InkWell(
                            child: const Icon(Icons.close_rounded),
                            onTap: () {
                              imcRepo.delete(imc);
                              setState(() {});
                            },
                          )),
                      onDismissed: (DismissDirection dismissDirection) async {
                        imcRepo.delete(imc);
                      },
                    );
                  },
                  itemCount: _IMCs.length,
                ),
        ),
      ),
    );
  }
}
