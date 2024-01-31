// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchForm extends StatelessWidget {
  SearchForm({
    required this.suggestions,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.controller,
    super.key,
  });
  var suggestions;
  var itemBuilder;
  var onSuggestionSelected;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 150),
      padding: const EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: 250,
          child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              style: BorderStyle.none, width: 0)))),
              suggestionsCallback: suggestions,
              itemBuilder: itemBuilder,
              onSuggestionSelected: onSuggestionSelected),
        ),
      ),
    );
  }
}
