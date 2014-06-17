AQUESTALKPI = "/home/pi/aquestalkpi/AquesTalkPi"
exec = require('child_process').exec

main = ->
  setInterval (->
    date = new Date()
    if true or (date.getHours() is 5 and
       date.getMinutes() is 0)
      hotaru()
      wait 5000, ->
        talk "しゅうぎょうじこくになりました。　かえりましょう。", ->
          wait 5000, ->
            talk "くにに、かえるんだな。おまえにも、かぞくがいるのだろう？", ->
    else
      talk "げんざいのじこくは、#{date.getHours()}じ、#{date.getMinutes()}ふん、です。"
  ), 60*1000

wait = (a, b)-> setTimeout(b, a)

talk = do ->
  talking = false
  (text, cb=->)->
    if talking then return cb(false)
    talking = true
    exec "#{AQUESTALKPI} \"#{text}\" | aplay", (err, stdout, stderr)->
      talking = false
      if !err then cb()
      else
        console.log err
        console.log err.code
        console.log err.signal

hotaru = ->
  exec "omxplayer hotarunohikari.mp3 --vol -1000", (err, stdout, stderr)->
    if !err then cb()
    else
      console.log err
      console.log err.code
      console.log err.signal

main()
