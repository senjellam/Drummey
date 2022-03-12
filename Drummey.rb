use_osc "localhost", 4560

live_loop :getThreshold do
  use_real_time
  setThreshold = sync "/osc*/setThreshold"
  set :gThreshold, setThreshold[0]
end

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

live_loop :jazzBass do
  use_real_time
  jazzDrums = sync "/osc*/jazzDrums"
  set :amp, jazzDrums[0]
  sample :drum_bass_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzSnare do
  use_real_time
  jazzDrums = sync "/osc*/jazzDrums"
  set :amp, jazzDrums[1]
  sample :drum_snare_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzTomTom1 do
  use_real_time
  jazzDrums = sync "/osc*/jazzDrums"
  set :amp, jazzDrums[2]
  sample :drum_tom_mid_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzTomTom2 do
  use_real_time
  jazzDrums = sync "/osc*/jazzDrums"
  set :amp, jazzDrums[3]
  sample :drum_tom_mid_soft, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzRide do
  use_real_time
  jazzDrums = sync "/osc*/jazzDrums"
  set :amp, jazzDrums[4]
  sample :drum_cymbal_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzHiHat do
  use_real_time
  jazzDrums = sync "/osc*/jazzDrums"
  set :amp, jazzDrums[5]
  sample :drum_cymbal_closed, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end