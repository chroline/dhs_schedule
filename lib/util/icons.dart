import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const icons = {
  'homeroom': {'Homeroom': FontAwesomeIcons.users},
  'math': {
    'Geometry': FontAwesomeIcons.shapes,
    'Mathematics': FontAwesomeIcons.calculator,
  },
  'science': {
    'Biology': FontAwesomeIcons.microscope,
    'Physics': FontAwesomeIcons.lightbulb,
    'Chemistry': FontAwesomeIcons.atom,
    'Science': FontAwesomeIcons.flask,
  },
  'language': {
    'English': FontAwesomeIcons.book,
    'Foreign Language': FontAwesomeIcons.comments
  },
  'socialStudies': {
    'History': FontAwesomeIcons.landmark,
    'US History': FontAwesomeIcons.flagUsa,
    'Political Science': FontAwesomeIcons.voteYea,
    'Geography': FontAwesomeIcons.globeAmericas,
    'Psychology': FontAwesomeIcons.brain
  },
  'appliedArts': {
    'Architecture': FontAwesomeIcons.rulerCombined,
    'Engineering': FontAwesomeIcons.draftingCompass,
    'Woodworking': FontAwesomeIcons.screwdriver,
    'Computer Science': FontAwesomeIcons.code,
    'Visual Arts': FontAwesomeIcons.brush
  },
  'business': {
    'Business': FontAwesomeIcons.briefcase,
    'Economics': FontAwesomeIcons.dollarSign
  },
  'gym': {
    'Health': FontAwesomeIcons.heart,
    'Weights': FontAwesomeIcons.dumbbell,
    'Gym': FontAwesomeIcons.running,
  },
};

Map allIcons = icons.entries.fold(
    {},
    (previousValue, element) =>
        previousValue..addEntries(element.value.entries));
