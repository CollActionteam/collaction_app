part of 'package:collaction_app/presentation/core/routes/app_page.dart';

extension AppPageExt on AppPage {
  // Route paths
  String get toPath {
    switch (this) {
      case AppPage.mainPage:
        return '/';
      case AppPage.home:
        return '/home';
      case AppPage.crowdActionDetails:
        return '/details';
      case AppPage.crowdActionParticipants:
        return '/participants';
      case AppPage.crowdActionsList:
        return '/view-all';
      case AppPage.userProfile:
        return '/user';
      case AppPage.profileDetails:
        return '/user/details';
      case AppPage.demoPage:
        return '/demo';
      case AppPage.componentsDemo:
        return '/demo/components';
      case AppPage.onBoarding:
        return '/onboarding';
      case AppPage.captive:
        return '/captive';
      case AppPage.auth:
        return '/auth';
      case AppPage.verified:
        return '/verified';
      case AppPage.settings:
        return '/settings';
      case AppPage.licenses:
        return '/licenses';
      case AppPage.contactForm:
        return '/contact-form';
      case AppPage.webView:
        return '/web-view';
      case AppPage.settingsLayout:
        return '/settings-layout';
    }
  }

  // Route Names
  String get toName {
    switch (this) {
      case AppPage.mainPage:
        return 'MAIN_PAGE';
      case AppPage.home:
        return 'HOME_PAGE';
      case AppPage.crowdActionDetails:
        return 'CROWDACTION_DETAILS';
      case AppPage.crowdActionParticipants:
        return 'CROWDACTION_PARTICIPANTS';
      case AppPage.crowdActionsList:
        return 'CROWDACTIONS_LIST';
      case AppPage.userProfile:
        return 'USER_PROFILE';
      case AppPage.profileDetails:
        return 'PROFILE_DETAILS';
      case AppPage.demoPage:
        return 'DEMO_PAGE';
      case AppPage.componentsDemo:
        return 'COMPONENTS_DEMO';
      case AppPage.onBoarding:
        return 'ONBOARDING';
      case AppPage.captive:
        return 'CAPTIVE';
      case AppPage.auth:
        return 'AUTH';
      case AppPage.verified:
        return 'VERIFIED';
      case AppPage.settings:
        return 'SETTINGS';
      case AppPage.licenses:
        return 'LICENSES';
      case AppPage.contactForm:
        return 'CONTACT_FORM';
      case AppPage.webView:
        return 'WEB_VIEW';
      case AppPage.settingsLayout:
        return 'SETTINGS_LAYOUT';
    }
  }
}
