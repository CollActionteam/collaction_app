import 'package:collaction_app/application/user_profile/profile_description/profile_description_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/user_details/user_details_bloc.dart';
import '../../domain/user/user.dart';
import '../../infrastructure/core/injection.dart';
import '../themes/constants.dart';
import 'profile_tab.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);
  // final bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<UserDetailsBloc>()
            ..add(const UserDetailsEvent.fetchDetails()),
        ),
        BlocProvider(
          create: (_) => getIt<ProfileDescriptionBloc>(),
        )
      ],
      child: BlocConsumer<UserDetailsBloc, UserDetailsState>(
        listener: (ctx, state) {
          state.maybeMap(
              fetchingDetailsFailed: (_) =>
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Error fetching details. Please try again.'),
                    ),
                  ),
              orElse: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Condition not registered'),
                  ),
                );
              });
        },
        builder: (ctx, state) {
          return state.maybeMap(
            fetchingDetails: (_) => const Center(
              child: CircularProgressIndicator(
                color: kAccentColor,
              ),
            ),
            fetchingDetailsSuccessful: (user) => StreamBuilder(
              stream: user.user,
              builder: (ctx, AsyncSnapshot<User> ss) => Stack(
                children: [
                  if (ss.hasData)
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 70, horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: CircleAvatar(
                              maxRadius: 50,
                              foregroundImage: NetworkImage(
                                // to be replaced with user profile image link
                                'https://static.remove.bg/remove-bg-web/dc31eaf79444b51662da45dcd6cf26fcda20b5dd/assets/start-1abfb4fe2980eabfbbaaa4365a0692539f7cd2725f324f904565a9a744f8e214.jpg',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              ss.data!.phoneNumber!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'About me',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<ProfileDescriptionBloc,
                              ProfileDescriptionState>(
                            builder: (ctx, state) {
                              return state ==
                                      const ProfileDescriptionState
                                          .modifyingDescription()
                                  ? TextFormField(
                                      maxLength: 150,
                                      maxLines: 5,

                                      // here comes the description of user
                                      initialValue:
                                          'Nam quis nulla. Integer malesuada. In in enim a arcu imperdiet malesuada. Sed vel lectus. Donec odio urna, tempus molestie, porttitor ut, iaculis quis',
                                    )
                                  : const Text('');

                              // state.maybeMap(
                              //   orElse: () => const Text('Or Else executed'),
                              //   updatingDescription: (_) => const Center(
                              //     child: CircularProgressIndicator(
                              //       color: kAccentColor,
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                          const SizedBox(height: 40),
                          RichText(
                            text: const TextSpan(
                              text: 'Joined ',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  // here comes the date on which the user joined CollAction
                                  text: 'January 2022',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity * 0.75, 52)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  side: const BorderSide(color: kAccentColor),
                                ),
                              ),
                            ),
                            // TextButton.styleFrom(
                            // padding: const EdgeInsets.all(16),
                            // shape: const CircleBorder(),
                            //
                            // ),
                            onPressed: () {},
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          const UserProfileTab()
                        ],
                      ),
                    )
                  else
                    const Text(
                        'Error fetching details. Please try again later!!'),
                ],
              ),
            ),
            orElse: () => const Center(
              child: Text('Error fetching Details. Please Try again later!!'),
            ),
          );
        },
      ),
    );
  }
}
