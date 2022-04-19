ENTITYDEFS = {
  ['player'] = {
    width = PLAYERWIDTH,
    height = PLAYERHEIGHT,
    x = 20,
    y = 32,
    offsetX = 0,
    offsetY = 5,
    texture = 'character_walk',
    walkSpeed = PLAYERSPEED,
    health = 6,
    damage = 2,
    animations = {
      ['walk_down'] = {
        frames = {1, 2, 3, 4},
        texture = 'character_walk',
        interval = 0.2
      },
      ['walk_right'] = {
        frames = {5, 6, 7, 8},
        texture = 'character_walk',
        interval = 0.2
      },
      ['walk_up'] = {
        frames = {9, 10, 11, 12},
        texture = 'character_walk',
        interval = 0.2
      },
      ['walk_left'] = {
        frames = {13, 14, 15, 16},
        texture = 'character_walk',
        interval = 0.2
      },
      ['idle_down'] = {
        frames = {1},
        texture = 'character_walk',
        -- looping = false
      },
      ['idle_right'] = {
        frames = {5},
        texture = 'character_walk',
        -- looping = false
      },
      ['idle_up'] = {
        frames = {9},
        texture = 'character_walk',
        -- looping = false
      },
      ['idle_left'] = {
        frames = {13},
        texture = 'character_walk',
        -- looping = false
      },
      ['sword_down'] = {
        frames = {1, 2, 3, 4},
        texture = 'character_sword',
        interval = 0.1
      },
      ['sword_right'] = {
        frames = {9, 10, 11, 12},
        texture = 'character_sword',
        interval = 0.1
      },
      ['sword_up'] = {
        frames = {5, 6, 7, 8},
        texture = 'character_sword',
        interval = 0.1
      },
      ['sword_left'] = {
        frames = {13, 14, 15, 16},
        texture = 'character_sword',
        interval = 0.1
      }}
  },
  ['skeleton'] = {
      texture = 'entities',
      health = 10,
      damage = 2,
      walkSpeed = ENTITYSPEED_FAST,
      animations = {
          ['walk_left'] = {
              frames = {22, 23, 24, 23},
              interval = 0.2
          },
          ['walk_right'] = {
              frames = {34, 35, 36, 35},
              interval = 0.2
          },
          ['walk_down'] = {
              frames = {10, 11, 12, 11},
              interval = 0.2
          },
          ['walk_up'] = {
              frames = {46, 47, 48, 47},
              interval = 0.2
          },
          ['idle_left'] = {
              frames = {23}
          },
          ['idle_right'] = {
              frames = {35}
          },
          ['idle_down'] = {
              frames = {11}
          },
          ['idle_up'] = {
              frames = {47}
          }
      }
  },
  ['slime'] = {
      texture = 'entities',
      health = 2,
      damage = .5,
      walkSpeed = ENTITYSPEED_SLOW,
      animations = {
          ['walk_left'] = {
              frames = {61, 62, 63, 62},
              interval = 0.2
          },
          ['walk_right'] = {
              frames = {73, 74, 75, 74},
              interval = 0.2
          },
          ['walk_down'] = {
              frames = {49, 50, 51, 50},
              interval = 0.2
          },
          ['walk_up'] = {
              frames = {86, 86, 87, 86},
              interval = 0.2
          },
          ['idle_left'] = {
              frames = {62}
          },
          ['idle_right'] = {
              frames = {74}
          },
          ['idle_down'] = {
              frames = {50}
          },
          ['idle_up'] = {
              frames = {86}
          }
      }
  },
  ['bat'] = {
      texture = 'entities',
      health = 2,
      damage = 3,
      walkSpeed = ENTITYSPEED_MEDIUM,
      animations = {
          ['walk_left'] = {
              frames = {64, 65, 66, 65},
              interval = 0.2
          },
          ['walk_right'] = {
              frames = {76, 77, 78, 77},
              interval = 0.2
          },
          ['walk_down'] = {
              frames = {52, 53, 54, 53},
              interval = 0.2
          },
          ['walk_up'] = {
              frames = {88, 89, 90, 89},
              interval = 0.2
          },
          ['idle_left'] = {
              frames = {64, 65, 66, 65},
              interval = 0.2
          },
          ['idle_right'] = {
              frames = {76, 77, 78, 77},
              interval = 0.2
          },
          ['idle_down'] = {
              frames = {52, 53, 54, 53},
              interval = 0.2
          },
          ['idle_up'] = {
              frames = {88, 89, 90, 89},
              interval = 0.2
          }
      }
  },
  ['ghost'] = {
      texture = 'entities',
      health = 15,
      damage = 1,
      walkSpeed = ENTITYSPEED_MEDIUM,
      animations = {
          ['walk_left'] = {
              frames = {67, 68, 69, 68},
              interval = 0.2
          },
          ['walk_right'] = {
              frames = {79, 80, 81, 80},
              interval = 0.2
          },
          ['walk_down'] = {
              frames = {55, 56, 57, 56},
              interval = 0.2
          },
          ['walk_up'] = {
              frames = {91, 92, 93, 92},
              interval = 0.2
          },
          ['idle_left'] = {
              frames = {68}
          },
          ['idle_right'] = {
              frames = {80}
          },
          ['idle_down'] = {
              frames = {56}
          },
          ['idle_up'] = {
              frames = {92}
          }
      }
  },
  ['spider'] = {
      texture = 'entities',
      health = 5,
      damage = 2,
      walkSpeed = ENTITYSPEED_FAST,
      animations = {
          ['walk_left'] = {
              frames = {70, 71, 72, 71},
              interval = 0.2
          },
          ['walk_right'] = {
              frames = {82, 83, 84, 83},
              interval = 0.2
          },
          ['walk_down'] = {
              frames = {58, 59, 60, 59},
              interval = 0.2
          },
          ['walk_up'] = {
              frames = {94, 95, 96, 95},
              interval = 0.2
          },
          ['idle_left'] = {
              frames = {71}
          },
          ['idle_right'] = {
              frames = {83}
          },
          ['idle_down'] = {
              frames = {59}
          },
          ['idle_up'] = {
              frames = {95}
          }
      }
  }
}
