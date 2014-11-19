require 'monadist'
require 'monadist/shims'
require 'json'

nothing = possibly_nil nil
maybe = possibly_nil '{"first_name":"Sam", "last_name":"Vimes"}'
list = list(['{"first_name":"Granny", "last_name":"Weatherwax"}', '{"first_name":"Nanny", "last_name":"Ogg"}'])
continuation = with '{"first_name":"Fred", "last_name":"Colon"}'
meanwhile = meanwhile_with '{"first_name":"Nobby", "last_name":"Nobbs"}'



def full_name(json_monad)
  json_monad.
    fmap { |json| JSON.parse json }.
    fmap { |person| "#{person['first_name']} #{person['last_name']}" }
end



p full_name(nothing).value
p full_name(maybe).value
p full_name(list).values
full_name(continuation).run { |full_name| p full_name }

full_name(meanwhile).run { |full_name| p full_name }
sleep 0.1 while Thread.list.count > 1
