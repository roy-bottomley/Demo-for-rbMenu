# a class to hold Flower data
@rbMenuDemoApp.factory 'Flower', [ ->
  class Flower
    constructor: (name, colors, scent, @url) ->
      @name = name.capitalizeFirstLetter()
      @key= "1##{@name}"
      @scent = scent.capitalizeFirstLetter()
      @colors = []
      for color in colors
        @colors.push(color.capitalizeFirstLetter())

      @menuItem =   {text: @name, menu_action: {emit: {flowerKey: @key}} , key: @key, sortKey: @key}


]