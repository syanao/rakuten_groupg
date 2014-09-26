# -*- coding: utf-8 -*-
require 'sinatra'
require 'rakuten_web_service'

#参考: https://github.com/k2works/sinatra_rakuten_api

require 'rubygems'
require 'json'
require 'pp'


get '/' do
  puts "<h1>No No No</h1>"
  RakutenWebService.configuration do |c|
    c.application_id = ENV["APPID"]
    c.affiliate_id = ENV["AFID"]
  end

  root = RakutenWebService::Ichiba::Genre.root # root genre
  # children returns sub genres
  root.children.each do |child|
    puts "[#{child.id}] #{child.name}"
  end
   
  # Use genre id to fetch genre object
  RakutenWebService::Ichiba::Genre[100316].name # => "水・ソフトドリンク"

  # Use genre id to fetch genre object
  @rankings = RakutenWebService::Ichiba::Item.ranking(:age => 30, :sex => 0)
  erb :item_ranking
end

get '/logger' do
  logger.info "loading data"
  # ...
end

get '/req' do
  t = %w[text/css text/html application/javascript]
  request.accept              # ['text/html', '*/*']
  request.accept? 'text/xml'  # true
  request.preferred_type(t)   # 'text/html'
  request.body                # クライアントによって送信されたリクエストボディ(下記参照)
  request.scheme              # "http"
  request.script_name         # "/example"
  request.path_info           # "/foo"
  request.port                # 80
  request.request_method      # "GET"
  request.query_string        # ""
  request.content_length      # request.bodyの長さ
  request.media_type          # request.bodyのメディアタイプ
  request.host                # "example.com"
  request.get?                # true (他の動詞にも同種メソッドあり)
  request.form_data?          # false
  request["some_param"]       # some_param変数の値。[]はパラメータハッシュのショートカット
  request.referrer            # クライアントのリファラまたは'/'
  request.user_agent          # ユーザエージェント (:agent 条件によって使用される)
  request.cookies             # ブラウザクッキーのハッシュ
  request.xhr?                # Ajaxリクエストかどうか
  request.url                 # "http://example.com/example/foo"
  request.path                # "/example/foo"
  request.ip                  # クライアントのIPアドレス
  request.secure?             # false (sslではtrueになる)
  request.forwarded?          # true (リバースプロキシの裏で動いている場合)
  request.env                 # Rackによって渡された生のenvハッシュ
end

get '/testjsonparse' do
#  RakutenWebService.configuration do |c|
#    c.application_id = ENV["APPID"]
#    c.affiliate_id = ENV["AFID"]
#  end
  
  json='{"President": "Alan Isaac","CEO": "David Richardson","India": ["Sachin Tendulkar","Virender Sehwag","Gautam Gambhir",],"Srilanka": ["Lasith Malinga", "Angelo Mathews", "Kumar Sangakkara"], "England": [ "Alastair Cook", "Jonathan Trott", "Kevin Pietersen"]}'
  #json = File.read('input.json')
  obj = JSON.parse(json)
  jsonFetch = obj.fetch("President")
  puts jsonFetch
  
end
