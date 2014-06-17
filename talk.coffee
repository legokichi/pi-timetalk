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
    talk "みなさん、ほんじつのさぎょうの、しゅうりょうじかんです。", ->
      wait 2000, ->
        talk "きょうもいちにち、ごくろうさまでした。", ->
          wait 2000, ->
            talk "みのまわりの、せいりせいとんを、かくにんして、おかえりください。", ->
              wait 2000, ->
                talk "あすもまた、きもちよく、けんきゅうにかかれるように、じゅんびをして、かえりましょう。", ->
                  wait 2000, ->
                    talk "きたくのとちゅうは、じゅうぶん、きをつけてください。", ->
                      wait 2000, ->
                        talk "ふかざけ、よふかしなどは、しないで、けんこういじに、つとめましょう。", ->
                          wait 2000, ->
                            talk "なお、ざんぎょうを、おこなうひとは、けいびいんに、もうしでてください。", ->
                              wait 2000, ->
                                talk "ほんじつは、けんきゅうかつどう、ごくろうさまでした。", ->

talk = do ->
  talking = false
  (text, cb=->)->
    if talking then return cb(false)
    talking = true
    exec "#{AQUESTALKPI} \"#{text}\" -s 70 | aplay", (err, stdout, stderr)->
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
