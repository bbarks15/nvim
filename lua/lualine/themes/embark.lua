local colors = {
    deep_space = '#100E23',
    space = '#1e1c31',
    eclipse = '#3E3859',
  
    red = '#F48FB1',
    dark_red = '#ff5458',
  
    green = '#A1EFD3',
    dark_green = '#62d196',
  
    yellow = '#ffe9aa',
    dark_yellow = '#ffb378',
  
    blue = '#91ddff',
    dark_blue = '#65b2ff',
  
    purple = '#c991e1',
    dark_purple = '#906cff',
  
    cyan = '#aaffe4',
    dark_cyan = '#63f2f1',
  
    clouds = '#cbe3e7',
    dark_clouds = '#6B697E',
  }
  
  local embark = {
    visual = {
      a = {fg = colors.deep_space, bg = colors.yellow, 'bold'},
      b = {fg = colors.deep_space, bg = colors.dark_yellow}
    },
    replace = {
      a = {fg = colors.deep_space, bg = colors.green, 'bold'},
      b = {fg = colors.deep_space, bg = colors.dark_green}
    },
    inactive = {
      c = {fg = colors.dark_clouds, bg = colors.deep_space},
      a = {fg = colors.dark_clouds, bg = colors.space, 'bold'},
      b = {fg = colors.dark_clouds, bg = colors.space}
    },
    normal = {
      c = {fg = colors.dark_clouds, bg = colors.space},
      a = {fg = colors.deep_space, bg = colors.green, 'bold'},
      b = {fg = colors.clouds, bg = colors.eclipse}
    },
    insert = {
      a = {fg = colors.deep_space, bg = colors.red, 'bold'},
      b = {fg = colors.deep_space, bg = colors.dark_red}
    }
  }
  
  return embark