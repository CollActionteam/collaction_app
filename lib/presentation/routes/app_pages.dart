part of 'app_routes.dart';

enum AppPage {
  mainPage('/'),
  home('/home'),
  crowdActionDetails('/details'),
  crowdActionParticipants('/participants'),
  crowdActionsList('/view-all'),
  userProfile('/user'),
  profileDetails('/user/details'),

  // Demo
  demoPage('/demo'),
  componentsDemo('/demo/components'),
  commentsDemo('/demo/comments'),
  onBoarding('/onboarding'),
  auth('/auth'),
  verified('/verified'),
  settings('/settings'),
  settingsLayout('/settings-layout'),
  licenses('/licenses'),
  contactForm('/contact-form'),
  unauthenticated('/unauthenticated'),
  webView('/web-view');

  final String path;

  const AppPage(this.path);

  static String crowdActionDetailsRoute(String id) =>
      '${AppPage.crowdActionDetails.path}/$id';
}
