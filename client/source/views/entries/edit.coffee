_ = require 'underscore'

PageView = require 'views/base/page'
tpl = require 'templates/entries/edit'

module.exports = class EntryEditView extends PageView
  template: tpl
  optionNames: PageView::optionNames.concat ['bucket', 'user']

  events:
    'submit form': 'submitForm'
    'click [href="#delete"]': 'clickDelete'

  getTemplateData: ->
    _.extend super,
      bucket: @bucket?.toJSON()
      user: @user?.toJSON()

  render: ->
    super
    _.defer =>
      @$('.form-control').get(0).focus()

  submitForm: (e) ->
    e.preventDefault()
    data = @$el.formParams no
    @model.save(data).fail @renderServerErrors

  clickDelete: (e) ->
    if confirm 'Are you sure?'
      @model.destroy(wait: yes)
