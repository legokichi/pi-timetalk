AQUESTALKPI = "/home/pi/aquestalkpi/AquesTalkPi"
exec = require('child_process').exec

main = ->
  shuugyou()
  a=->setInterval (->
    date = new Date()
    if date.getMinutes() is 0
      if date.getHours() is 19
        shuugyou()
      else
        talk "ぽ。ぽ。ぽ。ぽーん。#{date.getHours()}じになりました。"
  ), 60*1000

wait = (a, b)-> setTimeout(b, a)

shuugyou = ->
  hotaru()
  wait 5000, ->
    talk "みなさん、ほんじつのさぎょうのしゅうりょうじかんです。", ->
      talk "きょうもいちにち、ごくろうさまでした。", ->
        talk "みのまわりのせいりせいとんをかくにんしておかえりください。", ->
          talk "あすもまた、きもちよく、けんきゅうにかかれるように、じゅんびをしてかえりましょう。", ->
            talk "きたくのとちゅうは、じゅうぶんきをつけてください。", ->
              talk "ふかざけ、よふかしなどはしないで、けんこういじにつとめましょう。", ->
                talk "なお、ざんぎょうをおこなうひとはけいびいんにもうしでてください。", ->
                  talk "ほんじつはごくろうさまでした。", ->

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
  exec "omxplayer hotarunohikari.mp3 --vol -2000", (err, stdout, stderr)->
    if !err then cb()
    else
      console.log err
      console.log err.code
      console.log err.signal

main()
