# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#link_previous_title').autocomplete
    source: $('#link_previous_title').data('autocomplete-source')
  $('#link_next_title').autocomplete
    source: $('#link_next_title').data('autocomplete-source')
#  $('.next_storylet_link').each do storylet_link ->
#    link_next_id = $('label.string.optional').attr('for')
#    $('#' + link_next_id).autocomplete
#      source: $('#' + link_next_id).data('autocomplete-source')