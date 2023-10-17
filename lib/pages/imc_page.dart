import 'package:flutter/material.dart';
// import 'package:imc_app/classes/imc.dart';
import 'package:imc_app/models/imc_model.dart';
import 'package:imc_app/repositories/imc_repo.dart';

class CreateIMCPage extends StatefulWidget {
  const CreateIMCPage({super.key});

  @override
  State<CreateIMCPage> createState() => _CreateIMCPageState();
}

class _CreateIMCPageState extends State<CreateIMCPage> {
  var imcNameController = TextEditingController(text: "");
  var imcHeightController = TextEditingController(text: "");
  var imcWeightController = TextEditingController(text: "");
  late IMCRepository imcRepo;
  // ignore: non_constant_identifier_names
  var _IMCs = <IMCModel>[];

  Widget imcCreationDialog(BuildContext bc) {
    return AlertDialog(
      title: const Text("Calculate new IMC"),
      content: Column(
        children: [
          TextField(
            keyboardType: TextInputType.name,
            controller: imcNameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: imcWeightController,
            decoration: const InputDecoration(labelText: "Weight"),
          ),
          TextField(
            keyboardType: TextInputType.number,
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
    var name = imcNameController.text;
    var parsedHeight = double.tryParse(imcHeightController.text);
    var parsedWeight = double.tryParse(imcWeightController.text);

    if (parsedHeight != null && parsedWeight != null) {
      var imc = IMCModel.create(name, parsedHeight, parsedWeight);
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
    imcNameController.text = "";
    imcHeightController.text = "";
    imcWeightController.text = "";
  }

  void retrieveIMCs() {
    _IMCs = imcRepo.listAll();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    imcRepo = await IMCRepository.carregar();
    retrieveIMCs();
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
                      key: Key(imc.key.toString()),
                      child: ListTile(
                          title:
                              Text("IMC value: ${imc.imc.toStringAsFixed(2)}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Classification: ${imc.classification}"),
                              Text("Name: ${imc.name}")
                            ],
                          ),
                          trailing: InkWell(
                            child: const Icon(Icons.close_rounded),
                            onTap: () {
                              imcRepo.delete(imc);
                              retrieveIMCs();
                              setState(() {});
                            },
                          )),
                      onDismissed: (DismissDirection dismissDirection) async {
                        imcRepo.delete(imc);
                        retrieveIMCs();
                        setState(() {});
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
