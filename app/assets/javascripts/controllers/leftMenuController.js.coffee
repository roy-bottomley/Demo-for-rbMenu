# interfaces the flower editor html to the flowerService and changes the display when actions from the left rbMenu are received.
@rbMenuDemoApp.controller('leftMenuController', [ '$scope', 'flowerService', ($scope, flowerService)->

  # validate the editor values before saving
  validInput= (input) ->
    input? && input.length > 0

  $scope.checkInputs= () ->
    $scope.colorError = $scope.nameError = $scope.scentError = null
    $scope.colorError = 'At least one color must be specified' if !validInput($scope.flowerColors)
    $scope.nameError = 'A name must be specified' if !validInput($scope.flowerName)
    $scope.scentError = 'A scent must be specified' if !validInput($scope.flowerScent)
    !$scope.colorError? && !$scope.nameError?&& !$scope.scentError?

  # tell the flowerService to create a new flower
  $scope.createFlower= () ->
    if $scope.checkInputs()
      colors = $scope.flowerColors.split(',')
      result = flowerService.addFlower($scope.flowerName,colors, $scope.flowerScent)
      console.log('$scope.nameError')
      console.log($scope.nameError)
      if result.error
        $scope.nameError  = result.error
      else
        $scope.flower = result.flower
        confirm("Flower saved please check the Left menu to see the changes")

  # fetch the menu data from the flowerService into the variable passed into the rbMenu directive
  $scope.leftMenu = {sub_menu: flowerService.menus[flowerService.colorKey], key: 'rootItem'}

  # set the rbMenu configuration
  $scope.menuId = 'leftMenu'
  $scope.left_menu_config = {menu_type: 'vertical', on_left:true,  emit_id: $scope.menuId, style: {"background-color":'#fff'}}
  $scope.left_menu_config.prevent_offclick_close = true
  $scope.left_menu_config. prevent_lineclick_close = true

  # set the display to the default flower
  $scope.flower =   flowerService.getDefaultFlower()

  # listen for actions from the rbMenu and carry then out
  $scope.$on($scope.menuId, (e, args) ->
    if args.lineClicked?
      command = args.lineClicked
      if command.flowerKey?
        $scope.flower =   flowerService.getFlower(command.flowerKey)
      else if command.menuKey?
        $scope.leftMenu.sub_menu = flowerService.menus[command.menuKey]

  )

])