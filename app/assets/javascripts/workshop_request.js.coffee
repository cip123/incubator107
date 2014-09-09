(($, window) ->

  class FormValidator
    ERROR_CLASS = 'error'

    defaults: {}

    constructor: ($el, options) ->
      @$el = $el
      @options = $.extend({}, @defaults, options)
      @remove_uniqueness_validators()
      @bindEvents()


    bindEvents: ->
      @$el.on 'blur', '[data-validate]', (e) => @validateInput(e.currentTarget)
      @$el.on 'input', '[data-validate].error', (e) => @validateInput(e.currentTarget)
      @$el.on 'submit', @validateAll

    remove_uniqueness_validators: ->
      @$el.find('[data-validate]').each (_, el) ->
        validators = JSON.parse el.attributes["data-validate"].value

        for v in validators
          if v.kind == "uniqueness"
            index = validators.indexOf(v)
      
        if (index > -1) 
          validators.splice(index, 1)

        el.attributes["data-validate"].value = JSON.stringify validators

    validateAll: (e) =>
      $(e.currentTarget).find('[data-validate]').each (_, el) => @validateInput(el)

      

      if $(e.currentTarget).find('[data-validate].error')[0]
        e.stopPropagation()
        e.preventDefault()

    validateInput: (el) =>
      judge.validate(el, { valid: @_valid, invalid: @_invalid })

    _valid: (el) =>
      @getMsgItem(el)?.remove()
      $(el).removeClass(ERROR_CLASS)

    _invalid: (el, messages) =>
      @findOrCreateMsgItem(el).text(messages[0])
      $(el).addClass(ERROR_CLASS)

    findOrCreateMsgItem: (el) ->
      if (x = @getMsgItem(el))
        x
      else
        $item = $("<div class='error_message' />")
        $item.insertAfter($(el))
        $item

    getMsgItem: (el) ->
      if (x = $(el).parent().find('.error_message'))[0]
        x
      else
        null

  $.fn.extend addFormValidation: (option, args...) ->

   
    @each ->
      return unless $(@).find('[data-validate]')[0]
      data = $(@).data('form-validator')

      if !data
        $(@).data 'form-validator', (data = new FormValidator($(@), option))
      if typeof option == 'string'
        data[option].apply(data, args)

) window.jQuery, window

$ ->

  $('form').addFormValidation()
