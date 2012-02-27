# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $('#requirement_storylet_title').autocomplete
    source: $('#requirement_storylet_title').data('autocomplete-source')

  $('#requirement_quality_name').autocomplete
    source: $('#requirement_quality_name').data('autocomplete-source')