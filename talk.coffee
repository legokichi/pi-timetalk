AQUESTALKPI = "/home/pi/aquestalkpi/AquesTalkPi"
exec = require('child_process').exec

main = ->
  setInterval (->
    date = new Date()
    if date.getHours() is 5
       date.getMinutes() is 0
      hotaru()
      talk "しゅうぎょうじこくになりました。　かえりましょう。"
    talk "げんざいのじこくは、#{date.getHours()}じ、#{date.getMinutes()}ふん、です。"
  ), 60*1000



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
  exec "omxplayer hotarunohikari.mp3", (err, stdout stderr)->
    if !err then cb()
    else
      console.log err
      console.log err.code
      console.log err.signal

main()
