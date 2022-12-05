# Shoop v2
Melhoria do [shoopv1](https://github.com/kenjimaeda54/shop-flutter-v1/blob/develop/README.md) </br>
Agora e possível cadastra novos produtos e editar

## Feature
- Aprendi novos recursos usando Flutter exemplo: como utilizar o backgorundImage dentro do CirCleAvatar
- Ao utilizar backgorundImage precisamos usar o método NetWorkImage
- Quando está dentro  trailing é  você sente necessidade de usar   Row ou Column , e obrigatório determinar a largura, se não o Fluttern não ira renderizar da forma correta
- No exemplo abaixo o trailing esta renderizado dois botoes em linha

```dart

leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
),

//========
trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: handleNavigation,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: handleDelteProduct,
              )
            ],
          ),


```

##
- Para lidar com formulários em Dart existe duas possibilidades, a primeira e usar Controller e a segunda próprio Form
- Vantagem de usar Form que temos acesso a todos os campos quando submetido
- Para ser possível ter os campos e necessário usar   GlobalKey mais a propriedade saved 
- Também utilizando o GlobalKey temos acesso a validadores através do método  validator e validate()
- Se o validator retonrar null porque esta tudo ok

```dart

 //função validadora
 
 String? handleValidatorUrl(String? url) {
    final urlString = url ?? "";
    final absolutePath = Uri.tryParse(urlString)?.hasAbsolutePath ?? false;
    //possível validação se url não terminar com png,jpg
    // final endsWithFile = urlString.toLowerCase().endsWith(".png") ||
    //     urlString.toLowerCase().endsWith(".jpg") ||
    //     urlString.toLowerCase().endsWith(".jpeg");
    if (!absolutePath) {
      return "Url precisa ser valida ";
    }

    return null;
  }

 

 //método quando o formulario e submetido
  void handleSubmitForm() {
    final validator = _formKey.currentState?.validate() ?? false;

    if (!validator) {
      return;
    }

    _formKey.currentState?.save(); 
    final ProductListProvider provider = Provider.of(context, listen: false);

    if (provider.hasProduct(_formData)) {
      final productModel = ProductModel(
          id: _formData["id"] as String,
          title: _formData["name"] as String,
          description: _formData["description"] as String,
          price: double.parse(_formData["price"] as String),
          imageUrl: _formData["url"] as String);

      provider.updateProduct(productModel);
    } else {
      final productModel = ProductModel(
          id: "${Random().nextDouble().toString()}-${_formData["name"]}-${_formData["url"]}",
          title: _formData["name"] as String,
          description: _formData["description"] as String,
          price: double.parse(_formData["price"] as String),
          imageUrl: _formData["url"] as String);
      provider.addProdct(productModel);
    }
    Navigator.of(context).pop();
  }



//formualrio

 Form(
    key: _formKey,
        child: ListView(
            children: [
              TextFormField(
                initialValue: _formData["name"]?.toString(),
                decoration: const InputDecoration(label: Text("Nome")),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => handleFocus(_priceFoucs),
                onSaved: (name) => handleSave(text: name, field: "name"),
                validator: (name) =>
                    handleValitorFieldString(text: name, quantity: 3),
              ),
              
              
     )



```

##
- Desvantagem de não usar um controller, para criar um valor inicial preciso usar o initialValue
- Repare que abaixo o initialValue esta apontando para um Map 
-  Caso existam os argumentos enviados plea rota, sera instanciado no através do método [didChangeDependencies]//https://api.flutter.dev/flutter/widgets/State/didChangeDependencies.html) 
- Este método e acionado a cada mudança do state, então esta disponível apenas em classes StatefulWidget

```dart
 @override
  void didChangeDependencies() {
    //ciclo de vida toda vez que um state é alterado
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as ProductModel?;

    if (args != null) {
      //para os campos refletirem precisa colocar no initialState
      //do textfield
      //campos controlados pelo controller não precisam do
      //initialState
      _formData["id"] = args.id;
      _formData["name"] = args.title;
      _formData["price"] = args.price;
      _formData["description"] = args.description;
      _formData["url"] = args.imageUrl;
      //url esta no controller
      _urlController.text = args.imageUrl;
    }
  }
  
  
  
//
    TextFormField(
                initialValue: _formData["name"]?.toString(),
                decoration: const InputDecoration(label: Text("Nome")),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => handleFocus(_priceFoucs),
                onSaved: (name) => handleSave(text: name, field: "name"),
                validator: (name) =>
                    handleValitorFieldString(text: name, quantity: 3),
              ),




```
##
- Cuidado ao tentar desembrulhar as strings do metodo save
- O ideal e usar termnario se tentar desembrulhar por if ,pode gerar bugs




```dart
/text não posso desembrulhar usando != null
  void handleSave({String? text, bool? isDouble, required String field}) {
    if (isDouble != null) {
      //usar replace para trocar o , por  .
      _formData[field] = double.parse(text ?? "0");
    }
    _formData[field] = text ?? "ola";
  }




```






