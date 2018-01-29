#!/usr/bin/env ruby

require 'date'
require 'net/http'
require 'cgi'
require 'json'

INTRA_SESSION=ARGV[0]
PROJECT_SLUG=ARGV[1]

def console(message)
  puts "[#{DateTime.now.strftime('%F %T')}] #{message}"
end

def notification(message)
  `osascript -e 'display notification "#{message}" with title "Observateur de créneaux"'`

  console(message)
end

loop do
  uri = URI("https://projects.intra.42.fr/projects/#{PROJECT_SLUG}/slots.json")
  uri.query = URI.encode_www_form({
    start: Date.today.strftime('%F'),
    end: Date.today.next_day(3).strftime('%F')
  })

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri.request_uri)
  request['Cookie'] = CGI::Cookie.new('_intra_42_session_production', INTRA_SESSION).to_s
  response = http.request(request)

  slots = JSON.parse(response.body) rescue nil

  if response.is_a?(Net::HTTPSuccess)
    if slots.count > 0
      num = slots.map { |slot| slot['ids'].split(',').count }.reduce(:+)
      notification(num == 1 ? 'Un créneau est disponible !' : "#{num} créneaux est disponible !")
      #[{"ids":"oRgfgL7aUVeB0qoUFebcTg==,0gdbzh34RgfcBbuUwLIwLA==,tJpFYotTMzwWM8wRrpb7Jw==,D34URNn6Yvszg7h-BPCneA==","start":"2018-01-28T19:30:00.000+01:00","end":"2018-01-28T20:30:00.000+01:00","id":14494097,"title":"Available"}]
    else
      console('Aucun créneau disponible')
    end

    sleep 5
  else
    notification(slots && slots['error'] ? "Erreur: #{slots['error']}" : 'Erreur inconnu !')
    break
  end
end
