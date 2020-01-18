import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/pet_type.dart';
import 'package:pet_app/model/service_category.dart';

  class DropDownList extends StatefulWidget {
     final String hintText;
     final Function(String) onValueSelected;
     final String givenEnumClass;
    
     const DropDownList({Key key, this.onValueSelected, this.hintText, this.givenEnumClass}) : super(key: key);
     
      
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
          items:
          (widget.givenEnumClass == "PetType")? PetType.values.map((PetType classType) {
                return DropdownMenuItem<String>(
                  value: EnumToString.parse(classType),
                  child: Text(EnumToString.parse(classType)));
              }).toList():
          (widget.givenEnumClass == "ServiceCategory")? ServiceCategory.values.where((category) => (category != ServiceCategory.NotDefined))
              .map((ServiceCategory classType) {
            return DropdownMenuItem<String>(
                value: EnumToString.parse(classType),
                child: Text(EnumToString.parse(classType)));
          }).toList(): null,
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

