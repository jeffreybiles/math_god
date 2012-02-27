# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#quality_image_name').autocomplete
    source: $('#quality_image_name').data('autocomplete-source')

  $('#quality_storylet_title').autocomplete
    source: $('#quality_storylet_title').data('autocomplete-source')