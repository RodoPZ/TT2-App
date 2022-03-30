import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactosMain extends StatefulWidget {
  late Function(String) onStart;

  ContactosMain({required this.onStart,Key? key}) : super(key: key);

  @override
  _ContactosMain createState() => _ContactosMain();
}

class _ContactosMain extends State<ContactosMain> {
    List<Contact> contactos = [];

    getAllContacts() async {
      List<Contact> _contactos = await ContactsService.getContacts(withThumbnails: false);
      setState(() {
        contactos = _contactos;
      });
    }

    @override
    void initState() {
      print("owo");
      super.initState();
      getAllContacts();
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: contactos.length,
                itemBuilder: (context, index) {
                  Contact contacto = contactos[index];

                  return ListTile(
                    title: Text(contacto.displayName!),
                    subtitle: Text(contacto.phones!.length == 0
                        ? 'No Phone Number'
                        : contacto.phones!.elementAt(0).value.toString()),
                  );
                })
          ],
        ),
      );
    }
  }