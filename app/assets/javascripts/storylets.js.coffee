# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $('#storylet_preview_image_name').autocomplete
    source: $('#storylet_preview_image_name').data('autocomplete-source')

  $('#storylet_action_image_name').autocomplete
    source: $('#storylet_action_image_name').data('autocomplete-source')

  $('#storylet_success_image_name').autocomplete
    source: $('#storylet_success_image_name').data('autocomplete-source')

  $('#storylet_failure_image_name').autocomplete
    source: $('#storylet_failure_image_name').data('autocomplete-source')