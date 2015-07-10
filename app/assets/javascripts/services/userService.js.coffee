@rbMenuDemoApp.service 'userService', [ 'User', 'userUrls', 'rbMenuService',
  class userService
    constructor: (@User, @userUrls, @rbMenuService) ->

      # initial each menu with an empty array
      @menuList = []
      @imageList = []
      @goodGuys = []
      @badGuys = []

      # fake up a database
      @users = {}

      # get a list of image names and urls to teh full size image
      @availableImages = []
      for k,v of @userUrls
        @availableImages.push(name: k, url: v.full)

      # add some users
      @addUser('Roy', false)
      @addUser('Thor', false)
      @addUser('Darth', true)

      # specify a default user
      @defaultUser =  @users['Thor']

    # check for a valid name
    # just don't allow duplicates
    checkName= (name, users) ->
      for key, value of users
        if value.name == name
          return checkName(name += '(c)', users)
      name

    # add a user to either the good guy or bad guy menu lists
    # and make sure he isn't in the other one
    setGoodorBadGuyMenus= (rbMenuService, user, goodGuys, badGuys) ->
      if user.isBadGuy
        rbMenuService.removeMenuItem(user.key,goodGuys)
        rbMenuService.replaceMenuItem(user.key, badGuys, user.textMenuItem)
      else
        rbMenuService.removeMenuItem(user.key,badGuys)
        rbMenuService.replaceMenuItem(user.key, goodGuys, user.textMenuItem)


    # add a user to the database and the menu items
    addUser: (name, isBadGuy, imageName = null) ->
      # add to the database
      user = new @User(checkName(name, @users) , isBadGuy, @userUrls[(imageName || name)])
      @users[user.key] = user

      # add to the user list menu
      @rbMenuService.replaceMenuItem(user.key, @menuList, user.textMenuItem)
      # add to the user images menu
      @rbMenuService.replaceMenuItem(user.key, @imageList, user.imgMenuItem)
      # add to the good guy/bad gut menu
      setGoodorBadGuyMenus(@rbMenuService, user, @goodGuys, @badGuys)
      # return the newly added user
      user

   # get a User with the given key
    getUser: (key) ->
      user = @users[key] || @defaultUser

   # update a users data in the database and then update the menu items
    updateUser: (key, name, isBadGuy, imageName) ->
      # update the data base
      user = @users[key]
      user.update(name, isBadGuy, @userUrls[(imageName || name)])
      # update the user list menu
      @rbMenuService.replaceMenuItem(user.key, @menuList, user.textMenuItem)
      # update the user images menu
      @rbMenuService.replaceMenuItem(user.key, @imageList, user.imgMenuItem)
      # update the good guy/bad gut menu
      setGoodorBadGuyMenus(@rbMenuService, user, @goodGuys, @badGuys)

]
