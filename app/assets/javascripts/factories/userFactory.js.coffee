# a class to hold User data
@rbMenuDemoApp.factory 'User', [ ->
  class User
    constructor: (@name, @isBadGuy, images) ->
      @image = @name  if !@image?
      @key = @name

      @update(@name, @isBadGuy, images)

    # convert the isBadGuy variable to human readable text
    role= (isBadGuy) ->
      if isBadGuy then 'Bad Guy' else 'Good Guy'

    # combines the name and role to a text string
    title: () ->
      "#{@name}(#{role(@isBadGuy)})"

    # get the url for a given image size
    url: (imageSize)->
      imageSize = 'full' if !imageSize?
      @images[imageSize]

    # change the ytext displayed in the menus for the new User variables
    update: (@name, @isBadGuy, @images) ->
      @textMenuItem = {text: @title(),  img_url:  @url('tiny'), menu_action: {emit: @key}, key: @key, sortKey: @name}
      @imgMenuItem = {img_url: @url('thumb'),  tooltip: @name, menu_action: {emit: @key}, key: @key, sortKey: @name}

]