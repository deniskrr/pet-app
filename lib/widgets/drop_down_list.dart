
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/pet_type.dart';

  class DropDownList extends StatefulWidget {
     final String hintText;
     final Function(String) onValueSelected;
    
     const DropDownList({Key key, this.onValueSelected, this.hintText}) : super(key: key);
     
      
    @override
    _DropDownList createState() {
      return _DropDownList();
    }
  }
  
  class _DropDownList extends State<DropDownList> {
    String currentType;
    @override
    Widget build(BuildContext context) {
      return Center(
        child: DropdownButton<String>(
          items: PetType.values.map((PetType classType) {
                return DropdownMenuItem<String>(
                  value: EnumToString.parse(classType),
                  child: Text(EnumToString.parse(classType)));
              }).toList(),
          isExpanded: true,
          onChanged: (String value) {
            setState(() {
              currentType = value;
              widget.onValueSelected(currentType);
            });
          },
          hint: Text(widget.hintText),
          value: currentType,
        ),
      );
    }
  }
