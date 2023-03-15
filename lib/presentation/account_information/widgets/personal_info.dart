import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/personal_information/personal_information_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import 'personal_info_widgets/build_country_row.dart';
import 'personal_info_widgets/build_phone_row.dart';
import 'package:flutter/material.dart';

import '../../themes/constants.dart';
import 'personal_info_widgets/build_name_row.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonalInformationBloc>(
      create: (context) => getIt<PersonalInformationBloc>(),
      child: BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
        builder: (context, state) {
          return state.when(
            // TODO: Loading state
            fetching: () => Center(child: CircularProgressIndicator()),
            fetched: (userProfile) => Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Personal information",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor300,
                            fontSize: 16,
                          ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                BuildNameRow(
                  firstName: userProfile.profile.firstName,
                  lastName: userProfile.profile.lastName,
                ),
                BuildPhoneRow(),
                BuildCountryRow(location: userProfile.profile.location),
              ],
            ),
          );
        },
      ),
    );
  }
}
