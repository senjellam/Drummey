use_osc "localhost", 4560


# ===================================================================
# RECORDING (code by robin.newman)

define :pvalue do #get current listen port for Sonic Pi from log file
  value= 4557 #pre new logfile format port was always 4557
  File.open(ENV['HOME']+'/.sonic-pi/log/server-output.log','r') do |f1|
    while l = f1.gets
      if l.include?"Listen port:"
        value = l.split(" ").last.to_i
        break
      end
    end
    f1.close
  end
  return value
end

puts "Server Listen port is: #{pvalue}"
set :pvalue,pvalue

#three functions with will start recording, stop recording and save recorded audio file
define :recordStart do #this command is equivalent to pushing the start recording button
  use_real_time
  pvalue=get(:pvalue)
  osc_send "localhost",pvalue, "/start-recording","guid-rbn"
  sleep 1# make sure recording running before creating any audio to save
  puts "recording started"
end

define :recordStop do #this command stops a currently recording process
  use_real_time
  pvalue=get(:pvalue)
  osc_send "localhost",pvalue, "/stop-recording","guid-rbn"
end

define :saveAudio do |file|  #this command saves the recorded audio file
  pvalue=get(:pvalue)
  osc_send "localhost",pvalue, "/save-recording","guid-rbn",file
  puts "recording stopped"
end

#combine stop and save functions
define :stopAndSaveRecording do |file|
  recordStop
  saveAudio(file)
  puts "Recording saved to #{file}"
end


# ===================================================================
# GLOBAL VALUES

live_loop :getAttack do
  use_real_time
  setAttack = sync "/osc*/setAttack"
  set :gAttack, setAttack[0]
end

live_loop :getRelease do
  use_real_time
  setRelease = sync "/osc*/setRelease"
  set :gRelease, setRelease[0]
end

live_loop :getSustain do
  use_real_time
  setSustain = sync "/osc*/setSustain"
  set :gSustain, setSustain[0]
end

live_loop :getRate do
  use_real_time
  setRate = sync "/osc*/setRate"
  set :gRate, setRate[0]
end

live_loop :getDistortion do
  use_real_time
  setDistortion = sync "/osc*/setDistortion"
  set :gDistortion, setDistortion[0]
end

live_loop :getReverb do
  use_real_time
  setReverb = sync "/osc*/setReverb"
  set :gReverb, setReverb[0]
end

live_loop :getWobble do
  use_real_time
  setWobble = sync "/osc*/setWobble"
  set :gWobble, setWobble[0]
end


# ===================================================================
# START RECORDING

live_loop :getStart do
  use_real_time
  setStart = sync "/osc*/setStart"
  set :gStart, setStart[0]
  startRec = get(:gStart)
  if (startRec == 1)
    recordStart
  end
end


# ===================================================================
# FUSION DRUMS

live_loop :fusionBass do
  with_fx :reverb, mix: get(:gReverb) do
    use_real_time
    drumsFusion = sync "/osc*/drumsFusion"
    set :amp, drumsFusion[0]
    sample :drum_bass_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :fusionSnare do
  with_fx :reverb, mix: get(:gReverb) do
    use_real_time
    drumsFusion = sync "/osc*/drumsFusion"
    set :amp, drumsFusion[1]
    sample :drum_snare_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :fusionTomTom1 do
  with_fx :reverb, mix: get(:gReverb) do
    use_real_time
    drumsFusion = sync "/osc*/drumsFusion"
    set :amp, drumsFusion[2]
    sample :drum_tom_mid_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
    
  end
end

live_loop :fusionTomTom2 do
  with_fx :reverb, mix: get(:gReverb) do
    use_real_time
    drumsFusion = sync "/osc*/drumsFusion"
    set :amp, drumsFusion[3]
    sample :drum_tom_hi_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end


live_loop :fusionRide do
  with_fx :reverb, mix: get(:gReverb) do
    use_real_time
    drumsFusion = sync "/osc*/drumsFusion"
    set :amp, drumsFusion[4]
    sample :drum_cymbal_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :fusionHiHat do
  with_fx :reverb, mix: get(:gReverb) do
    use_real_time
    drumsFusion = sync "/osc*/drumsFusion"
    set :amp, drumsFusion[5]
    sample :drum_cymbal_closed, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :fusionTomTom3 do
  with_fx :reverb, mix: get(:gReverb) do
    use_real_time
    drumsFusion = sync "/osc*/drumsFusion"
    set :amp, drumsFusion[6]
    sample :drum_tom_lo_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end


# ===================================================================
# ROCK DRUMS

live_loop :rockBass do
  with_fx :distortion, mix: get(:gDistortion) do
    use_real_time
    drumsRock = sync "/osc*/drumsRock"
    set :amp, drumsRock[0]
    sample :drum_bass_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :rockSnare do
  with_fx :distortion, mix: get(:gDistortion) do
    use_real_time
    drumsRock = sync "/osc*/drumsRock"
    set :amp, drumsRock[1]
    sample :drum_snare_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :rockTomTom1 do
  with_fx :distortion, mix: get(:gDistortion) do
    use_real_time
    drumsRock = sync "/osc*/drumsRock"
    set :amp, drumsRock[2]
    sample :drum_tom_mid_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :rockTomTom2 do
  with_fx :distortion, mix: get(:gDistortion) do
    use_real_time
    drumsRock = sync "/osc*/drumsRock"
    set :amp, drumsRock[3]
    sample :drum_tom_hi_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :rockRide do
  with_fx :distortion, mix: get(:gDistortion) do
    use_real_time
    drumsRock = sync "/osc*/drumsRock"
    set :amp, drumsRock[4]
    sample :drum_cymbal_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :rockHiHat do
  with_fx :distortion, mix: get(:gDistortion) do
    use_real_time
    drumsRock = sync "/osc*/drumsRock"
    set :amp, drumsRock[5]
    sample :drum_cymbal_closed, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :rockTomTom3 do
  with_fx :distortion, mix: get(:gDistortion) do
    use_real_time
    drumsRock = sync "/osc*/drumsRock"
    set :amp, drumsRock[6]
    sample :drum_tom_lo_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end

live_loop :rockCrash do
  with_fx :distortion, mix: get(:gDistortion) do
    use_real_time
    drumsRock = sync "/osc*/drumsRock"
    set :amp, drumsRock[7]
    # sample :drum_cymbal_open, amp: get(:amp), attack: 0.2, sustain: 0.5, release: 0.7, rate: 1
    sample :drum_cymbal_open, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
  end
end


# ===================================================================
# JAZZ DRUMS

live_loop :jazzBass do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[0]
  sample :drum_bass_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
end

live_loop :jazzSnare do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[1]
  sample :drum_snare_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
end

live_loop :jazzTomTom1 do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[2]
  sample :drum_tom_mid_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
end

live_loop :jazzTomTom2 do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[3]
  sample :drum_tom_hi_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
end

live_loop :jazzRide do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[4]
  sample :drum_cymbal_hard, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
end

live_loop :jazzHiHat do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[5]
  sample :drum_cymbal_closed, amp: get(:amp), attack: get(:gAttack), release: get(:gRelease), sustain: get(:gSustain), rate: get(:gRate)
end


# ===================================================================
# STOP RECORDING

live_loop :getStop do
  use_real_time
  setStop = sync "/osc*/setStop"
  set :gStop, setStop[0]
  stopRec = get(:gStop)
  setPath = sync "/osc*/setPath"
  set :gPath, setPath[0]
  savePath = get(:gPath)
  if (stopRec == 1)
    stopAndSaveRecording(savePath)
  end
end
