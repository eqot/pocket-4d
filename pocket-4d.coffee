State =
  CLOSED: 0
  OPEN: 1

MouseState =
  RELEASED: 0
  PRESSED: 1

Polymer 'pocket-4d',
  state: State.CLOSED

  mouseState: MouseState.RELEASED
  mouseX: null
  mouseY: null
  dx: 0
  dy: 0

  child: null

  x: 100
  y: 100
  w: 100
  h: 100
  alignX: 'right'
  alignY: 'top'

  ready: ->
    @child = @.children[0]

    @close()

    @onMouseDown = @onMouseDown.bind(@)
    @onMouseMove = @onMouseMove.bind(@)
    @onMouseUp = @onMouseUp.bind(@)

  open: ->
    @setPosition @x, @y
    @setSize @w, @h

    @state = State.OPEN

    @.classList.add 'open'

    @enableMouseEvent()

  close: ->
    @setPosition 0, 0
    @setSize 0, 0

    @state = State.CLOSED

    @.classList.remove 'open'

    @disableMouseEvent()

  toggle: ->
    if @state is State.CLOSED
      @open()
    else
      @close()

  setPosition: (x, y) ->
    @.style[@alignX] = x + 'px'
    @.style[@alignY] = y + 'px'

  setSize: (width, height) ->
    @.style.width = width + 'px'
    @.style.height = height + 'px'

    @child.style.width = (width - 2) + 'px'
    @child.style.height = (height - 2) + 'px'

  enableMouseEvent: ->
    @.$.header.addEventListener 'mousedown', @onMouseDown, true
    document.addEventListener 'mousemove', @onMouseMove, true
    document.addEventListener 'mouseup', @onMouseUp, true

  disableMouseEvent: ->
    @.$.header.removeEventListener 'mousedown', @onMouseDown, true
    document.removeEventListener 'mousemove', @onMouseMove, true
    document.removeEventListener 'mouseup', @onMouseUp, true

  onMouseDown: (event) ->
    @mouseState = MouseState.PRESSED

    @mouseX = event.x + @dx
    @mouseY = event.y + @dy

    @.classList.add 'dragging'

    event.preventDefault()
    event.stopPropagation()

  onMouseMove: (event) ->
    if @mouseState is MouseState.RELEASED
      return

    dx = @mouseX - event.x
    dy = @mouseY - event.y

    dx *= -1 if @alignX is 'left'
    dy *= -1 if @alignY is 'top'

    @setPosition @x + dx, @y + dy

    event.preventDefault()
    event.stopPropagation()

  onMouseUp: (event) ->
    if @mouseState is MouseState.RELEASED
      return

    @mouseState = MouseState.RELEASED

    @dx = @mouseX - event.x
    @dy = @mouseY - event.y

    @.classList.remove 'dragging'

    event.preventDefault()
    event.stopPropagation()
