GAMEOBJECTDEFS = {
  ['switch'] = {
      type = 'switch',
      texture = 'switches',
      frame = 2,
      width = 16,
      height = 16,
      solid = false,
      defaultState = 'unpressed',
      states = {
        ['unpressed'] = {
          frame = 2,
        },
        ['pressed'] = {
          frame = 1
        }
      },
    },

  ['pot'] = {
    type = 'pickup',
    texture = 'tiles',
    frame = 33,
    width = 16,
    height = 16,
    solid = true,
    defaultState = 'closed',
    states = {
      ['closed'] = {
        frame = 33
      },
      ['open'] = {
        frame = 14
      },
      ['broken'] = {
        frame = 52
      }
    }
  }
}
