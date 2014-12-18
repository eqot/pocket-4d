State =
  CLOSED: 0
  OPEN: 1

Polymer 'pocket-4d',
  state: State.CLOSED

  child: null

  x: 100
  y: 100
  w: 100
  h: 100

  ready: ->
    @child = @.children[0]

  open: ->
    @setPosition @x, @y
    @setSize @w, @h

    @state = State.OPEN

  close: ->
    @setPosition 0, 0
    @setSize 0, 0

    @state = State.CLOSED

  toggle: ->
    if @state is State.CLOSED
      @open()
    else
      @close()

  setPosition: (x, y) ->
    @.style.left = x + 'px'
    @.style.top = y + 'px'

  setSize: (width, height) ->
    @.style.width = width + 'px'
    @.style.height = height + 'px'

    @child.style.width = (width - 2) + 'px'
    @child.style.height = (height - 2) + 'px'
