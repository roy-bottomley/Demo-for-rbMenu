# a class to hold Flower data
@rbMenuDemoApp.factory 'Flower', [ ->
  class Flower
    constructor: (name, colors, scent, @url) ->
      @name = $.trim(name).capitalizeFirstLetter()
      @key= @name
      sortkey= "1##{@name}"
      @scent = $.trim(scent).capitalizeFirstLetter()
      @colors = []
      for color in colors
        @colors.push($.trim(color).capitalizeFirstLetter())

      @menuItem =   {text: @name, menu_action: {emit: {flowerKey: @key}} , key: @key, sortKey: sortkey}


]