import 'package:flutter/material.dart';
import '../Gestores/GestorClientes.dart'; // Asegúrate de importar el archivo correcto
import '../Modelos/Cliente.dart'; // Asegúrate de importar el archivo correcto

class TestGestionClientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Correo electrónico para buscar
    String email = 'correo@example.com';

    // Obtener la lista de clientes
    List<Cliente> clientes = GestionClientes.getClientes();

    // Ejecutar el método buscarClientePorEmail
    Cliente? clienteEncontrado = GestionClientes.buscarClientePorEmail(email, clientes);

    // Mostrar el perfil del cliente encontrado
    if (clienteEncontrado != null) {
      // Si se encuentra el cliente, mostrar su perfil
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Perfil de ${clienteEncontrado.nombre}'),
            content: Text('Email: ${clienteEncontrado.correo}\nID: ${clienteEncontrado.id}\nPeso: ${clienteEncontrado.peso}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    } else {
      // Si no se encuentra el cliente, mostrar un mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('El cliente con el email $email no se encontró en la base de datos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }

    // Retorna un contenedor vacío ya que no necesitas renderizar nada en esta prueba
    return Container();
  }
}
