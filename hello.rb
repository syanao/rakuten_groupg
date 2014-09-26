# -*- coding: utf-8 -*-
require 'sinatra'
require 'rakuten_web_service'


#参考: https://github.com/k2works/sinatra_rakuten_api

# require 'rubygems'

get '/' do

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


