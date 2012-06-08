class Derp.Room
  constructor: (@room, @user) ->
    @ws = new WebSocket "ws://#{ SOCKET_HOST }/#{@room}/#{@user}"

    @ws.onmessage = (e) =>
      data = JSON.parse(e.data)
      comments = $('#comments')

      comments.append """
        <div class='message'>
          <div class='username #{if (data['user'] == @user) then 'myself' else '' }'>#{data['user']}</div>
          <div class='comment'>#{data['comment']}</div>
        </div>
      """

    @ws.onclose = => @setStatus('disconnected')
    @ws.onopen = => @setStatus('connected')

  sendMessage: ->
    @ws.send $('#comment').val()
    $('#comment').val ''

  setStatus: (str) ->
    $('#msg').text str
