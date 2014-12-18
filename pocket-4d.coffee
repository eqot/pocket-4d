State =
  CLOSED: 0
  OPEN: 1

Polymer 'pocket-4d',
  state: State.CLOSED

  child: null

  ready: ->
    @child = @.children[0]

  open: ->
    @setPosition 100, 100
    @setSize 500, 500

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
