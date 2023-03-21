import '../../../infrastructure/core/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/personal_information/personal_information_bloc.dart';
import '../../../application/user/profile/profile_bloc.dart';
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
        child: BlocProvider<ProfileBloc>.value(
            value: BlocProvider.of<ProfileBloc>(context),
            child:
                BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
                    builder: (context, state) {
              return state.when(
                // TODO: Loading state
                fetching: () => Center(child: CircularProgressIndicator()),
                fetched: (userProfile) =>
                    BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Personal information",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor300,
                                    fontSize: 16,
                                  ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        BuildNameRow(
                          firstName: state.userProfile!.profile.firstName,
                          lastName: state.userProfile!.profile.lastName,
                        ),
                        BuildPhoneRow(
                          phoneNumber: state.userProfile?.user.phoneNumber,
                        ),
                        BuildCountryRow(
                            location: state.userProfile!.profile.location),
                      ],
                    );
                  },
                ),
              );
            })));
  }
}
