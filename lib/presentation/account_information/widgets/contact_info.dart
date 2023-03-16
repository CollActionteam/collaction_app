import '../../../application/user/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/constants.dart';
import 'contact_info_widgets/build_email_row.dart';

class ContactInformation extends StatefulWidget {
  const ContactInformation({super.key});

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>.value(
        value: BlocProvider.of<ProfileBloc>(context),
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    "Contact information",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor300,
                          fontSize: 16,
                        ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              BuildEmailRow(
                email: state.userProfile?.user.email,
              ),
            ],
          );
        }));
  }
}
