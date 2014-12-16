Polymer 'pocket-4d',

  child: null

  ready: ->
    @child = @.children[0];

    @setSize 500, 500

  setPosition: (x, y) ->
    @.style.left = x + 'px';
    @.style.top = y + 'px';

  setSize: (width, height) ->
    @width = width;
    @height = height;

    @child.style.width = (@width - 2) + 'px';
    @child.style.height = (@height - 2) + 'px';
