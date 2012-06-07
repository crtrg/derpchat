
require 'em-websocket'
require 'json'
require 'uri'
require 'logger'

require 'v8'

EM.run do
  @logger = Logger.new(STDOUT)
  @channels = {}
  @members = {}

  EM::WebSocket.start(:host=>'0.0.0.0', :port => 8081) do |ws|
    ws.onopen {
      puts "==========================================="
      puts "open"
      puts "==========================================="
      puts room_name = ws.request['query']['room']
      puts user_name = ws.request['query']['user']

      p channel = @channels[room_name] || (@channels[room_name] = EM::Channel.new)
      p sid = channel.subscribe { |msg| ws.send msg }

      @logger.info("#{sid} join #{room_name}")

      members = @members[room_name] || (@members[room_name] = {})
      members[sid] = user_name

      ws.onmessage { |msg|
        puts "==========================================="
        puts "message"
        puts "==========================================="
        data = {
          :user    => user_name,
          :comment => msg,
          :user_id => sid
        }
        @logger.info(data)
        p channel
        channel.push(data.to_json)
      }

      ws.onclose {
        puts "==========================================="
        puts "close"
        puts "==========================================="
        members.delete(sid)
        data = {
          :user    => 'system',
          :comment => "#{user_name} disconnected",
          :user_id => 0,
          :members => members
        }
        @logger.info(data)
        channel.unsubscribe(sid)
      }

      data = {
        :user    => 'system',
        :comment => "#{user_name} connected",
        :user_id => 0,
        :members => members
      }
      @logger.info(data)
      channel.push(
        data.to_json
      )
    }
  end

  @logger.info('Server Started')
end


