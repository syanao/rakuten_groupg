# -*- coding: utf-8 -*-

require 'sinatra'
require 'json'
require 'net/http'
require 'uri'

get '/' do
  erb :search
end

post '/result' do
  uri = URI.escape("https://app.rakuten.co.jp/services/api/Travel/KeywordHotelSearch/20131024?format=json&keyword=#{params[:keyword]}&applicationId=1032836503936810161")
  response = Net::HTTP.get_response(URI.parse(uri))
  @jresponse = JSON.parse(response.body)
  erb :result
end

post '/detail' do
  puts params[:hotelNo]
  uri = URI.escape("https://app.rakuten.co.jp/services/api/Travel/HotelDetailSearch/20131024?format=json&hotelNo=#{params[:hotelNo]}&applicationId=1032836503936810161")
  response = Net::HTTP.get_response(URI.parse(uri))
  @jresponse = JSON.parse(response.body)
  puts @jresponse
  erb :detail
end
