$ =>
  # Initialize Zurb
  $(document).foundation()

  # For the scorll d plugin, whenever a link of the form id="*Btn" is clicked
  $("[id*='Btn']").stop(true).on 'click', (event)->
    # Prevent default event
    event.preventDefault()
    # Scroll to location
    $(@).scrolld()
