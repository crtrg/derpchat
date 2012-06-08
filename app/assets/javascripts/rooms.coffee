class Derp.Room
  constructor: (@room, @user) ->
    @ws = new WebSocket "ws://#{ SOCKET_HOST }/#{@room}/#{@user}"

    @ws.onmessage = (evt) =>
      data = JSON.parse(evt.data)

      if data['user'] == 'system'
        userClass = 'system'
        console.dir data
        @setParticipants(data['members'])
      else
        userClass = if data['user'] == @user
                      'myself'
                    else
                      ''

      comments = $('#comments')

      comments.append """
        <div class='message'>
          <div class='username #{userClass}'>#{data['user']}</div>
          <div class='comment'>#{data['comment']}</div>
        </div>
      """

    @ws.onclose = => @setStatus('disconnected')

    @ws.onopen = (evt) =>
      @setStatus('connected')

  sendMessage: ->
    @ws.send $('#comment').val()
    $('#comment').val ''

  setStatus: (str) ->
    $('#msg').text str
    if str == 'connected'
      $('#msg').css color: '#0a0'
    else if str == 'disconnected'
      $('#msg').css color: '#a00'

  setParticipants: (list) ->

    $('ul.participants').empty()
    for p in _(list).values()
      $('ul.participants').append("<li>#{p}</li>")

