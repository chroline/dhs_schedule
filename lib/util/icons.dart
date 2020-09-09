import 'package:flutter_icons/flutter_icons.dart';

const icons = {
  'math': {
    'Geometry': FontAwesome5Solid.shapes,
    'Mathematics': FontAwesome5Solid.calculator,
  },
  'science': {
    'Biology': FontAwesome5Solid.microscope,
    'Physics': FontAwesome5.lightbulb,
    'Chemistry': FontAwesome5Solid.atom,
    'Science': FontAwesome5Solid.flask,
  },
  'language': {
    'English': FontAwesome5Solid.book,
    'Foreign Language': FontAwesome5Solid.comments
  },
  'appliedArts': {
    'Architecture': FontAwesome5Solid.ruler_combined,
    'Engineering': FontAwesome5Solid.drafting_compass,
    'Woodworking': FontAwesome5Solid.screwdriver,
    'Computer Science': FontAwesome5Solid.code,
    'Graphic Design': FontAwesome5Solid.brush
  },
  'gym': {
    'Health': FontAwesome5Solid.heart,
    'Weights': FontAwesome5Solid.dumbbell,
    'Gym': FontAwesome5Solid.running,
  },
  'homeroom': {'Homeroom': FontAwesome5Solid.users},
};

Map allIcons = icons.entries.fold(
    {},
    (previousValue, element) =>
        previousValue..addEntries(element.value.entries));
