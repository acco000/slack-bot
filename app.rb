require 'sinatra'
require 'json'
# http://localhost:4567でブラウザからアクセスできる
get '/' do
  'hello world'
end