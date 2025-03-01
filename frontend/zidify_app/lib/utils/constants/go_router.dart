import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zidify_app/features/auth/ui/sign_in.dart';
import 'package:zidify_app/features/auth/ui/sign_up.dart';
import 'package:zidify_app/features/home/errro_page.dart';
import 'package:zidify_app/features/home/ui/history_screen.dart';
import 'package:zidify_app/features/home/ui/home_screen.dart';
import 'package:zidify_app/features/home/ui/profile_screen.dart';
import 'package:zidify_app/features/home/ui/widgets/main_wrapper.dart';
import 'package:zidify_app/features/home/ui/widgets/savings_tips_page.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/deposit_nav_classes.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_nav_classes.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/deposit/bloc/deposit_bloc.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/fund_destinations/cubit/fund_destination_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/funding_sources/cubit/funding_sources_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/make_deposit/cubit/deposit_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/make_withdrawal/cubit/withdraw_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/saveBox/cubit/save_box_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/withdraw/bloc/withdraw_bloc.dart';
import 'package:zidify_app/features/saveBox/ui/deposit_flow_pages/deposit_page1.dart';
import 'package:zidify_app/features/saveBox/ui/deposit_flow_pages/deposit_page2.dart';
import 'package:zidify_app/features/saveBox/ui/deposit_flow_pages/deposit_page3.dart';
import 'package:zidify_app/features/saveBox/ui/saveBox_main_screen.dart';
import 'package:zidify_app/features/saveBox/ui/savings_screen.dart';
import 'package:zidify_app/features/saveBox/ui/withdraw_flow_page/withdraw_page1.dart';
import 'package:zidify_app/features/saveBox/ui/withdraw_flow_page/withdraw_page2.dart';
import 'package:zidify_app/features/saveBox/ui/withdraw_flow_page/withdraw_page3.dart';
import 'package:zidify_app/features/saveGoals/ui/saveGoal_main_screen.dart';
import 'package:zidify_app/features/user/domain_layer/bloc/user_bloc.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/constants/navigation_params/route_helper.dart';

import 'package:zidify_app/utils/constants/texts.dart';

class AppGoRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorSavingsKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHistoryKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorProfileKey = GlobalKey<NavigatorState>();

  GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    // initialLocation: AppTexts.homeRoute, // Set initial location to home route
    initialLocation: AppTexts.signupRoute, // Set initial location to home route

    debugLogDiagnostics: true,
    routes: [
      // Sign In
      GoRoute(
        path: AppTexts.signinRoute,
        name: AppTexts.signinRouteName,
        builder: (context, state) => const SignInScreen(),
      ),
      // Sign Up
      GoRoute(
        path: AppTexts.signupRoute,
        name: AppTexts.signupRouteName,
        builder: (context, state) => const SignUpScreen(),
      ),

      StatefulShellRoute.indexedStack(
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state, navigationShell) {
            return MainWrapper(
              navigationShell: navigationShell,
            );
          },
          branches: [
            // Home
            StatefulShellBranch(navigatorKey: _shellNavigatorHomeKey, routes: [
              GoRoute(
                  path: AppTexts.homeRoute,
                  name: AppTexts.homeRouteName,
                  builder: (context, state) {
                    return const HomeScreen();
                  },
                  routes: [
                    // Savings Tips
                    GoRoute(
                        path: AppTexts.savingsTipsRoute,
                        name: AppTexts.savingsTipsRouteName,
                        builder: (context, state) => const SavingsTipsPage())
                  ]),
            ]),
            // Savings
            StatefulShellBranch(
              navigatorKey: _shellNavigatorSavingsKey,
              routes: [
                GoRoute(
                  path: AppTexts.savingsRoute,
                  name: AppTexts.savingsRouteName,
                  builder: (context, state) {
                    return BlocProvider.value(
                      value: sl<UserBloc>(),
                      child: SavingsScreen(),
                    );
                  },
                  routes: [
                    // SaveBox page
                    GoRoute(
                      path: AppTexts.saveBoxRoute,
                      name: AppTexts.saveBoxRouteName,
                      builder: (context, state) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider<SaveBoxCubit>(
                              create: (context) => sl<SaveBoxCubit>(),
                            ),
                          ],
                          child: const SaveboxMainScreen(),
                        );
                      },
                      routes: [
                        // Withdraw First  Screen
                        GoRoute(
                          path: AppTexts.withdrawFirstScreenRoute,
                          name: AppTexts.withdrawFirstScreenName,
                          builder: (context, state) =>
                              const WithdrawFirstScreen(),
                          routes: [
                            // Withdraw Second  Screen
                            GoRoute(
                              path: AppTexts.withdrawSecondScreenRoute,
                              name: AppTexts.withdrawSecondScreenName,
                              builder: (context, state) {
                                final params = RouteHelpers.getTypedParams<
                                    WithdrawalSecondScreenParams>(
                                  state,
                                  'WithdrawalSecondScreen',
                                );
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: sl<SaveBoxWithdrawalBloc>(),
                                    ),
                                    BlocProvider<FundDestinationCubit>(
                                      create: (context) =>
                                          sl<FundDestinationCubit>(),
                                    ),
                                  ],
                                  child: WithdrawSecondScreen(
                                    amount: params.amount,
                                  ),
                                );
                              },
                              routes: [
                                // Withdraw Third Screen
                                GoRoute(
                                  path: AppTexts.withdrawThirdScreenRoute,
                                  name: AppTexts.withdrawThirdScreenName,
                                  builder: (context, state) {
                                    final params = RouteHelpers.getTypedParams<
                                        WithdrawalThirdScreenParams>(
                                      state,
                                      'WithdrawalThirdScreen',
                                    );
                                    return BlocProvider(
                                      create: (context) => sl<WithdrawCubit>(),
                                      child: WithdrawThirdScreen(
                                        withdrawalParams:
                                            params.withdrawalParams,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Deposit First Screen

                        GoRoute(
                          path: AppTexts.depositFirstScreenRoute,
                          name: AppTexts.depositFirstScreenName,
                          builder: (context, state) =>
                              const DepositFirstScreen(),
                          routes: [
                            // Deposit Second  Screen
                            GoRoute(
                              path: AppTexts.depositSecondScreenRoute,
                              name: AppTexts.depositSecondScreenName,
                              builder: (context, state) {
                                final params = RouteHelpers.getTypedParams<
                                    DepositSecondScreenParams>(
                                  state,
                                  'DepositSecondScreen',
                                );
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) =>
                                          sl<SaveBoxDepositBloc>(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          sl<FundingSourcesCubit>(),
                                    ),
                                    BlocProvider.value(
                                      value: sl<SaveBoxCubit>()..getSaveBox(),
                                    ),
                                  ],
                                  child: DepositSecondScreen(
                                    amount: params.amount,
                                  ),
                                );
                              },
                              routes: [
                                // Deposit Third Screen
                                GoRoute(
                                  path: AppTexts.depositThirdScreenRoute,
                                  name: AppTexts.depositThirdScreenName,
                                  builder: (context, state) {
                                    final params = RouteHelpers.getTypedParams<
                                        DepositThirdScreenParams>(
                                      state,
                                      'DepositThirdScreen',
                                    );
                                    return BlocProvider(
                                      create: (context) => sl<DepositCubit>(),
                                      child: DepositThirdScreen(
                                        depositParams: params.depositParams,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // SaveGoal pages
                    GoRoute(
                      path: AppTexts.saveGoalRoute,
                      name: AppTexts.saveGoalRouteName,
                      builder: (context, state) => BlocProvider.value(
                        value: sl<UserBloc>(),
                        child: const SavegoalMainScreen(),
                      ),
                      routes: const [
                        // SaveGoal Main Screen
                        // GoRoute(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            //  History
            StatefulShellBranch(
                navigatorKey: _shellNavigatorHistoryKey,
                routes: [
                  GoRoute(
                      path: AppTexts.historyRoute,
                      name: AppTexts.historyRouteName,
                      builder: (context, state) {
                        return const HistoryScreen();
                      },
                      routes: const []),
                ]),
            //  Profile
            StatefulShellBranch(
                navigatorKey: _shellNavigatorProfileKey,
                routes: [
                  GoRoute(
                    path: AppTexts.profileRoute,
                    name: AppTexts.profileRouteName,
                    builder: (context, state) {
                      return const ProfileScreen();
                    },
                  ),
                ])
          ])
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}
