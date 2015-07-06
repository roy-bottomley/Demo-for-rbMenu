@rbMenuDemoApp.service 'flowerService', [ 'Flower', 'flowerUrls', 'rbMenuService',
  class flowerService
    constructor: (@Flower, @flowerUrls, @rbMenuService) ->
      # get a titleMenu item with the correct text for the menu being shown
      getTitleMenu= (key) ->
        {text: "Flowers #{key}", key: key, sortKey: '0#1',  divider: true}

      # define the keys of the menus to be used
      @colorKey = 'By Color'
      @scentKey = 'By Scent'
      @allKey = 'Show All'
      subMenuKeys =  [@allKey, @scentKey,@colorKey]

      # build a control menu which will slect the other menus
      controlSubMenu = ( {text: item, menu_action:  {emit: {menuKey: item}}, key: item, alwaysClose: true} for item in subMenuKeys )
      controlMenu =  {text: 'Organise', sub_menu: controlSubMenu, key: '0#2',  sortKey: '0#2',  divider: true}

      # a hash to save the menus in for easy access
      @menus = {}

      # initial each menu with a title and the control menu
      for key in subMenuKeys
        @menus[key] = [getTitleMenu(key), controlMenu]

      # add some data, faking up a database here to keep the demo simple
      # a hash to save the flowers in
      @flowers = {}
      @defaultFlower = @flowerUrls['default']

      @addFlower('Carnation', ['Red'], 'Floral')
      @addFlower('Dill', ['Yellow'], 'Aromatic')
      @addFlower('Lavender', ['Blue'], 'Aromatic')
      @addFlower('Rose', ['Red'], 'Floral')
      @addFlower('Eucalyptus', ['Green'], 'Aromatic')
      @addFlower('Eucharis', ['White'], 'Citrus')
      @addFlower('Orange blossom', ['White'], 'Citrus')
      @addFlower('Lily', ['Pink'], 'Exotic', 'lily')
      @addFlower('African Lily', ['Blue'], 'Exotic')
      @addFlower('Freesia', ['Purple','Red','Yellow','White'], 'Floral')
      @addFlower('Hyacinth', ['Pink','Red','Purple','Blue','White','Yellow'], 'Floral')

    # find the menu in the menu list and create one if none exists
    getMenu= (rbMenuService, key, menuList) ->
      # build a new menu item
      newMenu = {text: key, sub_menu: [], key: key, sortKey: key}
      # then pass of the work to rbMenuService
      rbMenuService.getMenuItem(key, menuList,newMenu)

    # verify the name is a valid flower name
    checkName= (name, flowers) ->
      name? && !flowers[name.capitalizeFirstLetter()]?

    # add a flower to the database and the menus
    addFlower: (name,color,scent,  doSort = true) ->
      if checkName(name, @flowers)
        # create flower and add to database

        flower = new @Flower(name, color, scent, @flowerUrls[name] || @defaultFlower)
        @flowers[flower.key] = flower

        # add a menu item in the 'all flowers' menu
        @rbMenuService.replaceMenuItem(flower.key, @menus[@allKey], flower.menuItem)

        # find the scent menu from the list of scents
        # and create the scent menu if one doesn't exist
        scentMenu =  getMenu(@rbMenuService, flower.scent, @menus[@scentKey]).sub_menu
        # add teh flower to the scent menu
        @rbMenuService.replaceMenuItem(flower.key, scentMenu, flower.menuItem)

        # for each of the flowers colors add the flower to the appropiate color menu
        for color in flower.colors
          colorMenu = getMenu(@rbMenuService, color, @menus[@colorKey]).sub_menu
          @rbMenuService.replaceMenuItem(flower.key,  colorMenu, flower.menuItem)

        # return null rather than an error message
        null
      else
        "Flower name exists"

    # get a flower from the database
    getFlower: (key) ->
      @flowers[key]

    # get the default flower from the database
    getDefaultFlower: () ->
      @flowers[Object.keys(@flowers)[0]]

]
