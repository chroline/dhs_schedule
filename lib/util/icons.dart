import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const icons = {
  'school': {
    'School': FontAwesomeIcons.school,
    'Homeroom': FontAwesomeIcons.users
  },
  'math': {
    'Geometry': FontAwesomeIcons.shapes,
    'Mathematics': FontAwesomeIcons.calculator,
    'Statistics': FontAwesomeIcons.chartBar
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
  'business': {
    'Business': FontAwesomeIcons.briefcase,
    'Economics': FontAwesomeIcons.dollarSign,
    'Investing': FontAwesomeIcons.chartLine
  },
  'appliedArts': {
    'Architecture': FontAwesomeIcons.rulerCombined,
    'Engineering': FontAwesomeIcons.draftingCompass,
    'Woodworking': FontAwesomeIcons.screwdriver,
    'Computer Science': FontAwesomeIcons.code,
  },
  'fineArts': {
    'Visual Arts': FontAwesomeIcons.brush,
    'Photography': FontAwesomeIcons.camera,
    'Yearbook': FontAwesomeIcons.bookOpen
  },
  'music': {
    'Band': FontAwesomeIcons.drum,
    'Guitar': FontAwesomeIcons.guitar,
    'Music': FontAwesomeIcons.music,
    'Theatre': FontAwesomeIcons.theaterMasks
  },
  'gym': {
    'Health': FontAwesomeIcons.heart,
    'Weights': FontAwesomeIcons.dumbbell,
    'Gym': FontAwesomeIcons.running,
    'Traffic Safety': FontAwesomeIcons.car,
    'Child Development': FontAwesomeIcons.baby
  },
};

Map allIcons = icons.entries.fold(
    {},
    (previousValue, element) =>
        previousValue..addEntries(element.value.entries));
