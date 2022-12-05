# Shoop v2
Melhoria do [shoopv1](https://github.com/kenjimaeda54/shop-flutter-v1/blob/develop/README.md) </br>
Agora e possivel cadastar novos produtos e editar

## Feature
- Aprendi novos recursos usando Flutter como utilizar o backgorundImage dentro do CirCleAvatar
- Ao utilizar backgorundImage precisamos usar o metodo NetWorkImage
- Quando esta dentro  trailing e precisa usar   Row ou Column , e obrigatorio determinar a largura, se nao o Fluttern nao ira renderizar da forma correta
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
- Para lidar com formularios em Dart existe duas posibilidades a primeria e usar Controller e a segunda proprio Form
- Vantagem de usar Form que temos acesso a todos campos quando submetido
- Para ser possivel ter os campos e necessario usar   GlobalKey mais a propriedade saved 
- Tambem utilizando o GlobalKey temos acesso a validadores atraves do meotod validator e validate()
- Se o validator retonrar null e porque esta tudo ok

```dart

 //funcao validaora
 
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

 

 //metodo quando o fomrulairo e submetido
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
- Desvantagem de nao usar um controller e nao consigo instanciar um valor apenas no inicio sem usar o initialValue
- Repare que abaixo o initialValue esta apontando para um Map que caso exista os argumentos sera instanciado no inicio atraves do metodo [didChangeDependencies]//https://api.flutter.dev/flutter/widgets/State/didChangeDependencies.html) este metodo e acionado a cada mudanca do state,entao esta diponsivel apenas e em StatefulWidget


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






