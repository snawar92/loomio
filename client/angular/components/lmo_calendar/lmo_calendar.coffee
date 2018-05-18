moment = require 'moment'

EventBus = require 'shared/services/event_bus'

{ calendarMonth } = require 'shared/helpers/calendar'

angular.module('loomioApp').directive 'lmoCalendar', ->
  scope: {}
  templateUrl: 'generated/components/lmo_calendar/lmo_calendar.html'
  controller: ['$scope', ($scope) ->
    $scope.today     = moment()
    $scope.current   = $scope.today.clone()
    $scope.dayNames  = ['日','月','火','水','木','金','土']

    $scope.changeMonth = (diff = 0) ->
      $scope.current.add(diff, 'month')
      $scope.weeks = calendarMonth $scope.current
    $scope.changeMonth()

    $scope.selectDate = (date) ->
      EventBus.emit $scope, 'dateSelected', date
  ]
