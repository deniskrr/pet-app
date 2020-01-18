import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/user/user_service.dart';
import 'package:pet_app/widgets/no_match_search.dart';
import 'package:pet_app/widgets/pet_sitter_list_view.dart';

class PetSitterSearchResults extends StatelessWidget {
  final Pet forPet;
  final UserService _userService = services.get<UserService>();
  final AuthService _authService = services.get<AuthService>();

  PetSitterSearchResults({@required this.forPet});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userService.getPetSitters(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<User> petSitters = snapshot.data;
          if (petSitters.isNotEmpty)
            return PetSitterListView(
              petSitters: petSitters,
            );
          else
            return NoMatchSearch();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
