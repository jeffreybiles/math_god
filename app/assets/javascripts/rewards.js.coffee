# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#reward_storylet_title').autocomplete
    source: $('#reward_storylet_title').data('autocomplete-source')

  $('#reward_quality_name').autocomplete
    source: $('#reward_quality_name').data('autocomplete-source')