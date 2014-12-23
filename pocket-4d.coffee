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
  w: 500
  h: 500
  alignX: 'right'
  alignY: 'top'

  ready: ->
    @child = @.children[0]

    @close()

    @onMouseDown = @onMouseDown.bind(@)
    @onMouseMove = @onMouseMove.bind(@)
    @onMouseUp = @onMouseUp.bind(@)
    @onKeyDown = @onKeyDown.bind(@)

  append: (child) ->
    @appendChild child

    @child = @.children[0]

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
    @.$.dialog.style[@alignX] = x + 'px'
    @.$.dialog.style[@alignY] = y + 'px'

  setSize: (width, height) ->
    @.$.dialog.style.width = width + 'px'
    @.$.dialog.style.height = height + 'px'

    if @child?
      width = width - 2 if width > 0
      height = height - 2 if height > 0

      @child.style.width = width + 'px'
      @child.style.height = height + 'px'

  enableMouseEvent: ->
    @.$.header.addEventListener 'mousedown', @onMouseDown, true
    document.addEventListener 'mousemove', @onMouseMove, true
    document.addEventListener 'mouseup', @onMouseUp, true
    document.addEventListener 'keydown', @onKeyDown, true

  disableMouseEvent: ->
    @.$.header.removeEventListener 'mousedown', @onMouseDown, true
    document.removeEventListener 'mousemove', @onMouseMove, true
    document.removeEventListener 'mouseup', @onMouseUp, true
    document.removeEventListener 'keydown', @onKeyDown, true

  onMouseDown: (event) ->
    @mouseState = MouseState.PRESSED

    @mouseX = event.clientX + @dx
    @mouseY = event.clientY + @dy

    @.$.dialog.classList.add 'dragging'

    event.preventDefault()
    event.stopPropagation()

  onMouseMove: (event) ->
    if @mouseState is MouseState.RELEASED
      return

    dx = @mouseX - event.clientX
    dy = @mouseY - event.clientY

    dx *= -1 if @alignX is 'left'
    dy *= -1 if @alignY is 'top'

    @setPosition @x + dx, @y + dy

    event.preventDefault()
    event.stopPropagation()

  onMouseUp: (event) ->
    if @mouseState is MouseState.RELEASED
      return

    @mouseState = MouseState.RELEASED

    @dx = @mouseX - event.clientX
    @dy = @mouseY - event.clientY

    @.$.dialog.classList.remove 'dragging'

    event.preventDefault()
    event.stopPropagation()

  onKeyDown: (event) ->
    if event.keyCode is 27
      @close()

      event.preventDefault()
      event.stopPropagation()
