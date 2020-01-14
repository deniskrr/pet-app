  import 'package:flutter/material.dart';
  import 'package:pet_app/model/pet_type.dart';
  import 'package:enum_to_string/enum_to_string.dart';

  class DropDownList extends StatefulWidget {
     String type;


    @override
    _DropDownList createState() {
      return _DropDownList();
    }
  }
  
  class _DropDownList extends State<DropDownList> {
  
    @override
    Widget build(BuildContext context) {
      return Center(
        child: DropdownButton<String>(
          items: PetType.values.map((PetType classType) {
                return DropdownMenuItem<String>(
                  value: EnumToString.parse(classType),
                  child: Text(EnumToString.parse(classType)));
              }).toList(),
          onChanged: (String value) {
            setState(() {
              widget.type = value;
            });
          },
          hint: Text('Pet type'),
          value: widget.type,
        ),
      );
    }
  }