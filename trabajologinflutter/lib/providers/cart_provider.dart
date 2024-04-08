import 'package:flutter/material.dart';


class CartProvider extends ChangeNotifier{
  List<String> _listaAlbum = [];
  //List<Item> _listaItem = [];

  List<String> get listaAlbum => _listaAlbum;
  //List<Item> get listaItems => _listaItem
  void add(String album){
    _listaAlbum.add(album);
    notifyListeners();
  }

  void remove(String album){
    _listaAlbum.remove(album);
    notifyListeners();
  }

}