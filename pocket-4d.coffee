Polymer 'pocket-4d',

  child: null

  ready: ->
    @child = @.children[0];

  setPosition: (x, y) ->
    @.style.left = x + 'px';
    @.style.top = y + 'px';

  setSize: (width, height) ->
    @.style.width = width + 'px';
    @.style.height = height + 'px';

    @child.style.width = (width - 2) + 'px';
    @child.style.height = (height - 2) + 'px';
