###*
 * Swipe helper is a helper class that allows you to define
 * navigation elements anywhere on the DOM for any swipe object.
 *
 * - Define the swipe wrapper with a 'data-swipe' attribute (an id on this element is required)
 * - The navigation elements are 'data-swipe-next' and 'data-swipe-previous'
 * - The navigation elements require an additional 'data-swipe-id' attribute with the
 * value of the wrapper's id
 *
 *
 * Example:
 *   <div id="photos">
 *    <button class="button" data-swipe-previous data-swipe-id="kristenAndMikeSwipe">Previous</button>
 *    <button class="button" data-swipe-next data-swipe-id="kristenAndMikeSwipe">Next</button>
 *    <div id="kristenAndMikeSwipe" data-swipe>
 *      <ul class="swipe-wrap">
 *        <li>
 *            <h1>First Slide</h1>
 *            <a href="#" class="button" data-swipe-next data-swipe-id="kristenAndMikeSwipe">See Photos</a>
 *        </li>
 *        <li>
 *          <img src="http://placehold.it/1000x300/A92B48/fff" alt="slide 2" />
 *        </li>
 *        <li>
 *          <img src="http://placehold.it/1000x300/A92B48/fff" alt="slide 3" />
 *        </li>
 *      </ul>
 *    </div>
 *  </div>
###

class SwipeHelper
  constructor : ->
    # Initialize empty amount of swipe objects
    @swipeObjects = {}

  autoDetect : ->
    # For every element with the class of swipe
    for el in $('[data-swipe]')
      do (el)=>
        # Store elements
        $el = $ el
        swipeId = $el.attr 'id'

        # Initialize a swipe element
        swipeObject = $el.Swipe().data('Swipe')
        # Add to index
        @swipeObjects[swipeId] = swipeObject

    @bindNavigationClicks()


  bindNavigationClicks : ->
    # When a next element is clicked
    $('body').on 'click', '[data-swipe-next]', (event)=>
      event.preventDefault()
      # Store elements
      $el = $ event.currentTarget
      swipeId = $el.attr 'data-swipe-id'
      swipeObject = @swipeObjects[swipeId]

      # Next slide
      swipeObject.next()

    # When a previous element is clicked
    $('body').on 'click', '[data-swipe-previous]', (event)=>
      event.preventDefault()
      # Store elements
      $el = $ event.currentTarget
      swipeId = $el.attr 'data-swipe-id'
      swipeObject = @swipeObjects[swipeId]

      # Next slide
      swipeObject.prev()


# Exports
window.SwipeHelper = new SwipeHelper