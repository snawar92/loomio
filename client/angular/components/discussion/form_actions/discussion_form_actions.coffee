Records       = require 'shared/services/records.coffee'
EventBus      = require 'shared/services/event_bus.coffee'
LmoUrlService = require 'shared/services/lmo_url_service.coffee'

{ submitForm }    = require 'shared/helpers/form.coffee'
{ submitOnEnter } = require 'shared/helpers/keyboard.coffee'

angular.module('loomioApp').directive 'discussionFormActions', ->
  scope: {discussion: '='}
  replace: true
  templateUrl: 'generated/components/discussion/form_actions/discussion_form_actions.html'
  controller: ['$scope', ($scope) ->
    actionName = if $scope.discussion.isNew() then 'created' else 'updated'

    $scope.submit = submitForm $scope, $scope.discussion,
      flashSuccess: "discussion_form.messages.#{actionName}"
      successCallback: (response) =>
        discussion = Records.discussions.find(data.discussions[0].id)
        EventBus.emit $scope, 'nextStep', discussion
        _.invoke Records.documents.find($scope.discussion.removedDocumentIds), 'remove'
        LmoUrlService.goTo LmoUrlService.discussion(discussion) if actionName == 'created'

    submitOnEnter $scope
  ]
