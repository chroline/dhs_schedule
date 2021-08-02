import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const icons = {
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
  'appliedArts': {
    'Architecture': FontAwesomeIcons.rulerCombined,
    'Engineering': FontAwesomeIcons.draftingCompass,
    'Woodworking': FontAwesomeIcons.screwdriver,
    'Computer Science': FontAwesomeIcons.code,
    'Graphic Design': FontAwesomeIcons.brush
  },
  'gym': {
    'Health': FontAwesomeIcons.heart,
    'Weights': FontAwesomeIcons.dumbbell,
    'Gym': FontAwesomeIcons.running,
  },
  'homeroom': {'Homeroom': FontAwesomeIcons.users},
};

Map allIcons = icons.entries.fold(
    {},
    (previousValue, element) =>
        previousValue..addEntries(element.value.entries));
