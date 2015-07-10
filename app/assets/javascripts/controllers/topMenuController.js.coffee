# interfaces the user editor html to the userService and changes the display when actions from the top rbMenu are received.
@rbMenuDemoApp.controller('topMenuController', [ '$scope',  'userService',  ($scope, userService)->

  # retrieve user data from the user service and arrange it into menu items
  buildTopMenu= (userService) ->
    menuUsers = {text: 'Users', sub_menu: userService.menuList}

    menuImages = {text: 'Images', sub_menu: userService.imageList}

    rolesSubMenu = [ {text: 'Good Guys', sub_menu: userService.goodGuys},
      {text: 'Bad Guys', sub_menu: userService.badGuys}]
    menuRoles = {text: 'Roles', sub_menu: rolesSubMenu}

    linksSubMenu = [ {text: "Roy Bottomley's Home Page", menu_action: {url: 'http://www.roy-bottomley.com'}},
      {text: "This Demo project on GitHub", menu_action: {url: 'https://github.com/roy-bottomley/Demo-for-rbMenu.git'}},
      {text: "rbMenu on GitHub", menu_action: {url: 'https://github.com/roy-bottomley/rbMenu.git'}}
    ]
    menuLinks =  {text: 'Links', sub_menu: linksSubMenu}

    toolTipItem = {text: "This has a tooltip", tooltip: "A tool tip"}
    toolTipItem2 = {text: "This has a link and a tooltip", tooltip: "link to Roy Bottomley's home page",  menu_action: {url: 'http://www.roy-bottomley.com'}}

    {sub_menu: [ toolTipItem, toolTipItem2, menuUsers, menuRoles, menuImages, menuLinks], key: 'rbMenuTop'}

  # specify the configuration for the top rbMenu
  setTopMenuConfig= () ->
    $scope.menuId = 'topMenu'
    $scope.forceSmallScreen = false
    $scope.hasTopBar = true
    $scope.menu_config = {on_left: false, emit_id: $scope.menuId, primary_menu: true}

  # validate the editor values before saving
  validInput= (input) ->
    input? && input.length > 0

  $scope.checkInputs= () ->
    if !validInput($scope.currentName)
      confirm("Name must be at least 1 character long")
      false
    else if  $scope.currentKey == 'Roy' || $scope.currentName == 'Roy'
      confirm("Roy is a Superhero and cannot be modified.\n Please select another used from the Main menu")
      false
    else if   $scope.selectedImage.name == 'Roy'
      confirm("Roy is a Superhero no one else may masquerade as him.\n Please select another used from the Main menu")
      false
    else
      true

  # save change to the userService
  $scope.saveUser= (createNew) ->
    if  $scope.checkInputs()
      if createNew
        user = userService.addUser($scope.currentName, $scope.currentIsBadGuy, $scope.selectedImage.name)
        $scope.setUserInEditor(userService.getUser(user.key))
        confirm("User created please check the Main menu to see the changes")
      else
        userService.updateUser($scope.currentKey, $scope.currentName, $scope.currentIsBadGuy, $scope.selectedImage.name)
        confirm("User saved please check the Main menu to see the changes")

  # sets the variables used for the editors inout/disply to the currentky selected User
  $scope.setUserInEditor= (user) ->
    $scope.currentKey = user.key
    $scope.currentIsBadGuy = user.isBadGuy
    $scope.currentName = user.name
    for option in $scope.imageNameOptions
      if user.url() == option.url
        $scope.selectedImage = option
        $scope.currentImageUrl = option.url
        break

  # build the menu data into the variable passed into the rbMenu directive
  $scope.topMenu =  buildTopMenu(userService)

  # set the rbMenu configuration
  setTopMenuConfig()

  # define the variable used in the editors dropdown to select good or bad guys
  $scope.badGuyOptions = [{name: 'Good Guy', value: false},
    {name: 'Bad Guy', value: true},
  ]

  # define the variable used in the editors dropdown to select images
  $scope.imageNameOptions = userService.availableImages

  # set the display to the default user
  $scope.setUserInEditor(userService.getUser())

  # listen for actions from the rbMenu and carry then out
  $scope.$on($scope.menuId, (e, args) ->
    if args.lineClicked?
      $scope.setUserInEditor( userService.getUser(args.lineClicked))
    else if args.menuTypeChange?
      $scope.hasTopBar =  args.menuTypeChange
  )

])