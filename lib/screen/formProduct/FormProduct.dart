import 'package:flutter/material.dart';

class FormProduct extends StatefulWidget {
  const FormProduct({Key? key}) : super(key: key);

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final _priceFoucs = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    void handleFocus(FocusNode node) {
      Focus.of(context).requestFocus(node);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de produtos"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("Nome")),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => handleFocus(_priceFoucs),
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Preço")),
                textInputAction: TextInputAction.next,
                focusNode: _priceFoucs,
                onFieldSubmitted: (_) => handleFocus(_descriptionFocus),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Preço")),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
